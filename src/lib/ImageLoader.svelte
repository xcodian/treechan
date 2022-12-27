<script>
    export let src;
    export let alt;

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

    export var width = 0
    export var height = 0
</script>

<IntersectionObserver once={true} let:intersecting>
    {#if intersecting || nativeLoading}
        <Image bind:width bind:height {alt} {src} />
    {/if}
</IntersectionObserver>
