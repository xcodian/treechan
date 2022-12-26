<script>
    export let src;
    export let alt;

    import { onMount } from "svelte";

    let loaded = false;
    let thisImage;

    onMount(() => {
        thisImage.onload = () => {
            loaded = true;
        };
    });
</script>

<img {src} {alt} bind:this={thisImage} loading="lazy" />

<style>
</style>
