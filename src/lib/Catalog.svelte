<script lang="ts">
    import OP from "./OP.svelte";

    export var board;
    var catalog_pages = [];
    var loading = false;

    $: getCatalog(board);

    async function getCatalog(b) {
        loading = true;
        const res = await fetch(`/a/${board}/catalog.json`);
        catalog_pages = await res.json();
        loading = false;
    }
</script>

<div class="threads">
    {#if loading}
        <div class="loading">
            Loading /{board}/...
        </div>
    {:else}
        {#each catalog_pages as { page, threads } (page)}
            {#each threads as op (op.no)}
                <OP {board} {op} />
            {/each}
        {/each}
    {/if}
</div>

<style>
    .threads {
        display: flex;
        flex-direction: column;
        gap: 1em;
    }

    @media only screen and (max-width: 600px) {
        .threads {
            gap: 0.5em;
        }
    }

    .loading {
        font-size: 24pt;
        text-align: center;
    }
</style>
