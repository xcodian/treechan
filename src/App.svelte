<script lang="ts">
    import { onMount } from "svelte";
    import catalog_pages from "./lib/catalog_pages.json";
    import Thread from "./lib/Thread.svelte";
</script>

<main>
    <h1>treechan</h1>
    <div class="threads">
        {#each catalog_pages as { page, threads } (page)}
            {#each threads as thread (thread.no)}
                <Thread board="po" thread={thread} />
            {/each}
        {/each}
    </div>
</main>

<style>
    .threads {
        display: flex;
        flex-direction: column;
        gap: 1em;
    }
</style>
