<script>
    export let src;
    export let alt;
    export let placeholderWidth;
    export let placeholderHeight;

    import { onMount } from "svelte";

    let loaded = false;
    let thisImage;

    onMount(() => {
        thisImage.onload = () => {
            loaded = true;
        };
    });
</script>

<div>
    {#if !loaded}
        <div
            class="placeholder"
            style="width: {placeholderWidth}px; height: {placeholderHeight}px;"
        />
    {/if}
    <img {src} {alt} bind:this={thisImage} loading="lazy" />
</div>

<style>
    img {
        border-radius: 3px;
    }

    .placeholder {
        background-color: rgba(0, 0, 0, 0.25);
    }
</style>
