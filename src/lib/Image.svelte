<script>
    export let src;
    export let alt;
    export var width;
    export var height;

    import { onMount } from "svelte";

    let loaded = false;
    let thisImage;

    onMount(() => {
        thisImage.onload = () => {
            loaded = true;
        };
    });
</script>

<div bind:clientWidth={width} bind:clientHeight={height}>
    <img {src} {alt} bind:this={thisImage} loading="lazy" />
</div>

<style>
    img {
        border-radius: 3px;
    }
</style>
