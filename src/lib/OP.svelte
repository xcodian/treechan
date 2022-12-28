<script lang="ts">
    import ImageLoader from "./ImageLoader.svelte";
    import ReplyTree from "./ReplyTree.svelte";
    import PostInfo from "./PostInfo.svelte";
    import PostContent from "./PostContent.svelte";

    export var board;
    export var op;
    var expanded = false;
    var replies = [];

    async function toggleReplies() {
        expanded = !expanded;

        if (expanded && replies.length === 0) {
            const res = await fetch(`/a/${board}/thread/${op.no}.json`);
            replies = (await res.json()).posts;
        }
    }
</script>

<div class="thread">
    <PostInfo post={op} {board}>
        {#if op["sticky"]}
            <div class="status" style="color: greenyellow;">sticky</div>
        {/if}
        {#if op["closed"]}
            <div class="status" style="color: orangered;">closed</div>
        {/if}
    </PostInfo>

    <PostContent {board} post={op}>
        <div class="t-actions">
            <!-- svelte-ignore a11y-click-events-have-key-events -->
            <div class="t-action" on:click={toggleReplies}>
                {expanded ? "Hide" : "View"}
                {op.replies} Replies
            </div>
            <div class="t-action">
                {op.images} Images
            </div>
        </div>
    </PostContent>

    {#if expanded}
        <div style="padding-top: 8px; overflow-x: scroll;">
            {#if replies.length}
                <ReplyTree {board} {replies} />
            {:else}
                <div>Loading replies...</div>
            {/if}
        </div>
    {/if}
</div>

<style>
    .thread {
        background-color: #1e1e1e;
        border-radius: 8px;
        padding: 1em;
        justify-content: left;
    }

    @media only screen and (max-width: 600px) {
        .thread {
            border-radius: 0px;
        }
    }

    .t-actions {
        display: flex;
        gap: 8px;
        color: gray;
        padding-top: 8px;
    }

    .t-action {
        background-color: rgba(0, 0, 0, 0.25);
        padding: 5px;
        padding-inline: 10px;
        cursor: pointer;
        border-radius: 8px;
    }

    .status {
        cursor: default;
        user-select: none;
    }
</style>
