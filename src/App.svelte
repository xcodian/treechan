<script lang="ts">
    import BoardList from "./lib/BoardList.svelte";
    import Catalog from "./lib/Catalog.svelte";

    let board = null;
</script>

<main class:mtop={board == null}>
    <span class="title">treechan</span>
    <span class="subtitle">Tree-based based 4chan client</span>
    <BoardList bind:current={board} />
    {#if board}
        <Catalog {board} />
    {/if}
</main>

<style>
    main {
        display: flex;
        flex-direction: column;
        gap: 32px;
    }

    .mtop {
        margin-top: 200px;
    }

    .title {
        font-size: 40pt;
    }

    .subtitle {
        font-size: 24pt;
    }

    @media only screen and (max-width: 600px) {
        .title {
            margin-inline: 2rem;
        }

        .subtitle {
            margin-inline: 2rem;
            line-height: 1;
        }

        .mtop {
            margin-top: 20px;
        }
    }
</style>
