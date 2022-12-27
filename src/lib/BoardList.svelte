<script lang="ts">
    import { onMount } from "svelte";

    let boards = [];
    export var current;

    onMount(async () => {
        const res = await fetch(
            `/a/boards.json`
        );
        boards = (await res.json()).boards;
    });
</script>

<div class="boards">
    {#each boards as board (board.board)}
        <!-- svelte-ignore a11y-click-events-have-key-events -->
        <div
            class="board tooltip"
            class:current={current == board.board}
            on:click={() => (current = board.board)}
        >
            {board.board}
            <span class="tooltiptext">{board.title}</span>
        </div>
    {/each}
</div>

<style>
    .board {
        background-color: rgba(0, 0, 0, 0.25);
        padding: 5px;
        padding-inline: 10px;
        cursor: pointer;
        border-radius: 8px;
    }

    .boards {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
    }

    .current {
        background-color: #fbc02d;
        color: black;
    }

    .tooltip {
        position: relative;
        display: inline-block;
        border-bottom: 1px dotted black;
    }

    .tooltip .tooltiptext {
        visibility: hidden;

        background-color: black;
        color: #fff;

        text-align: center;

        border-radius: 6px;
        padding: 8px;

        position: absolute;
        top: -48px;
        left: 50%;
        transform: translate(-50%, 0);
        width: max-content;

        /* Position the tooltip */
        z-index: 1;

        pointer-events: none;
    }

    .tooltip .tooltiptext::after {
        content: "";
        position: absolute;
        top: 100%;
        left: 50%;
        margin-left: -5px;
        border-width: 5px;
        border-style: solid;
        border-color: black transparent transparent transparent;
    }

    .tooltip:hover .tooltiptext {
        visibility: visible;
    }
</style>
