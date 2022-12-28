<script lang="ts">
    import { each } from "svelte/internal";
    import ImageLoader from "./ImageLoader.svelte";
    import PostContent from "./PostContent.svelte";
    import PostInfo from "./PostInfo.svelte";

    export var board;
    export var root;
    export var post = null;
    export var onlyChildren: Boolean = false;
    var collapse = false;

    if (post == null) {
        post = root;
    }
</script>

<div style="position: relative;">
    {#if !onlyChildren}
        <div class="thread">
            <PostInfo {post} {board} {root}>
                {#if post.children.size}
                    <!-- svelte-ignore a11y-click-events-have-key-events -->
                    <div
                        style="cursor: pointer; user-select: none;"
                        on:click={() => (collapse = !collapse)}
                    >
                        {collapse ? "[+]" : "[-]"}
                    </div>
                {/if}
            </PostInfo>
            <PostContent {board} {post} />
        </div>
    {/if}
    {#if !collapse}
        <div class="t-children" class:t-indent={!onlyChildren}>
            {#each [...post.children] as child}
                <svelte:self {root} {board} post={child} />
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
        min-width: 200px;
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
