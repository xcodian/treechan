<script>
    export let src;
    export let alt;
    export let placeholderWidth;
    export let placeholderHeight;

    import { onMount, tick } from "svelte";
    import { nsfw_model } from "./stores";

    let loaded = false;
    let thisImage;
    let predicted = "Checking NSFW...";
    let nsfw = $nsfw_model != null;
    let error = false;

    onMount(async () => {
        thisImage.onload = async () => {
            loaded = true;

            await tick();

            let predictions = await $nsfw_model.classify(thisImage);

            nsfw = !(
                predictions[0].className == "Drawing" ||
                predictions[0].className == "Neutral"
            );
            if (nsfw) {
                predicted = `${predictions[0].className} ${
                    Math.round(predictions[0].probability * 100 * 100) / 100
                }%`;
            }
        };
    });

    $: nsfw = nsfw && $nsfw_model != null;
</script>

<div
    class="img-container"
    style="width: {placeholderWidth}px; height: {placeholderHeight}px; overflow: hidden;"
>
    <!-- {#if !loaded}
        <div
            class="placeholder"
            style="width: {placeholderWidth}px; height: {placeholderHeight}px;"
        />
    {/if} -->
    {#if !error}
        <img
            {src}
            {alt}
            bind:this={thisImage}
            class:nsfw
            loading="lazy"
            on:error={() => (error = true)}
        />
    {/if}
    {#if loaded && nsfw}
        <div class="predict">
            {predicted}
        </div>
    {/if}
</div>

<style>
    img {
        border-radius: 3px;
    }

    /* .placeholder {
        background-color: rgba(0, 0, 0, 0.25);
    } */

    .nsfw {
        filter: blur(12px);
        overflow: hidden;
    }

    .nsfw:hover {
        filter: none;
    }

    .nsfw:hover + .predict {
        display: none;
    }

    .img-container {
        position: relative;
    }

    .predict {
        margin: auto;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        z-index: 10;
        min-width: max-content;
        background-color: rgba(0, 0, 0, 0.7);
        padding: 0.5em;
        border-radius: 8px;
        pointer-events: none;
    }
</style>
