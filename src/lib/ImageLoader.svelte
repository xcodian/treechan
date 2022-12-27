<script>
    export let src;
    export let alt;
    export let placeholderWidth = 100;
    export let placeholderHeight = 200;

    import { onMount } from "svelte";
    import IntersectionObserver from "./IntersectionObserver.svelte";
    import Image from "./Image.svelte";
    let nativeLoading = false;
    // Determine whether to bypass our intersecting check
    // onMount(() => {
    //   if ('loading' in HTMLImageElement.prototype) {
    //     nativeLoading = true
    //   }
    // })
</script>

<IntersectionObserver once={true} let:intersecting>
    {#if intersecting || nativeLoading}
        <Image {placeholderHeight} {placeholderWidth} {alt} {src} />
    {:else}
        <div
            class="placeholder"
            style="width: {placeholderWidth}px; height: {placeholderHeight}px;"
        />
    {/if}
</IntersectionObserver>

<style>
    .placeholder {
        background-color: rgba(0, 0, 0, 0.25);
    }
</style>
