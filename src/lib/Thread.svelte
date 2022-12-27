<script lang="ts">
    import ImageLoader from "./ImageLoader.svelte";
    import ReplyTree from "./ReplyTree.svelte";
    import dayjs from "dayjs";

    export var board;
    export var thread;
    var expanded = false;
    var replies = [];

    var post_time = dayjs.unix(thread.time);

    async function toggleReplies() {
        expanded = !expanded;

        if (expanded && replies.length === 0) {
            while (true) {
                try {
                    const res = await fetch(
                        `http://localhost:8080/http://a.4cdn.org/${board}/thread/${thread.no}.json`
                    );
                    replies = (await res.json()).posts;
                    break;
                } catch (error) {
                    console.log(error);
                }
            }
        }
    }
</script>

<div class="thread">
    <div class="t-info">
        <div class="t-no">
            <span style="color: #FBC02D">#{thread.no}</span> by
            <span style="color: #4DB6AC">{thread.name}</span>
            at
            <span style="color: #03A9F4"
                >{post_time.format("DD/MM/YYYY - HH:MM")} ({post_time.fromNow()})</span
            >
            {thread["id"] ? `(ID ${thread["id"]})` : ""}
        </div>
        <div style="flex-grow: 1" />
        {#if thread["sticky"]}
            <div class="status" style="color: greenyellow;">sticky</div>
        {/if}
        {#if thread["closed"]}
            <div class="status" style="color: orangered;">closed</div>
        {/if}
    </div>

    <div
        class="t-content"
        class:flex-wrap={thread.w > thread.h && thread.com?.length >= 250}
    >
        <div class="t-img">
            <ImageLoader
                src="http://localhost:8080/http://i.4cdn.org/{board}/{thread.tim}s.jpg"
                alt={thread.filename}
            />
        </div>

        <div>
            <div class="t-sub">{thread.sub}</div>
            <div class="t-com">{@html thread.com}</div>

            <div class="t-actions">
                <div class="t-action" on:click={toggleReplies}>
                    {thread.replies} Replies
                </div>
                <div class="t-action">
                    {thread.images} Images
                </div>
            </div>
        </div>
    </div>

    {#if expanded}
        <div style="padding-top: 8px;">
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
    .t-info {
        display: flex;
        gap: 4px;
        color: gray;
        padding-bottom: 8px;
    }

    .t-sub {
        font-weight: bold;
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

    .t-content {
        display: flex;
        gap: 16px;
    }

    .flex-wrap {
        flex-wrap: wrap;
    }

    .status {
        cursor: default;
        user-select: none;
    }
</style>
