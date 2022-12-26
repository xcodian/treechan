<script lang="ts">
    import { each } from "svelte/internal";
    import ImageLoader from "./ImageLoader.svelte";

    export var board;
    export var reply;
    export var onlyChildren: Boolean = false;
    var collapse = false;
</script>

<div style="position: relative;">
    {#if !onlyChildren}
        <div class="thread">
            <div class="t-info">
                <div class="t-no">
                    #{reply.no} by {reply.name}
                    {reply.now}
                    {reply["id"] ? `(ID ${reply["id"]})` : ""}
                </div>
                <div style="flex-grow: 1" />
                {#if reply.children.size}
                    <div
                        style="cursor: pointer; user-select: none;"
                        on:click={() => (collapse = !collapse)}
                    >
                        {collapse ? "[+]" : "[-]"}
                    </div>
                {/if}
            </div>
            <!-- <ImageLoader
                src="http://localhost:8080/http://i.4cdn.org/{board}/{reply.tim}s.jpg"
                alt={reply.filename}
            /> -->
            <div class="t-com">{@html reply.com}</div>
        </div>
    {/if}
    {#if !collapse}
        <div class="t-children" class:t-indent={!onlyChildren}>
            {#each [...reply.children] as child}
                <svelte:self board={board} reply={child} />
            {/each}
        </div>
    {/if}
</div>

<style>
    .thread {
        background-color: rgba(0, 0, 0, 0.25);
        border-radius: 6px;
        padding: 8px;
        justify-content: left;
        margin-block: 4px;
    }

    .t-info {
        display: flex;
        gap: 4px;
        color: gray;
        padding-bottom: 8px;
    }

    .t-children {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .t-indent {
        padding-left: 25px;
    }
</style>
