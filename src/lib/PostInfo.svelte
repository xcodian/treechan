<script lang="ts">
    export let post;
    export let root = null;
    export let board;
    import dayjs from "dayjs";

    let post_time = dayjs.unix(post.time);
</script>

<div class="info">
    <span>
        <a
            href={root == null
                ? `https://boards.4channel.org/${board}/thread/${post.no}`
                : `https://boards.4channel.org/${board}/thread/${root.no}#p${post.no}`}
            style="color: #FBC02D">#{post.no}</a
        >
        by
        <span style="color: #4DB6AC">{post.name}</span>
        at
        <span style="color: #03A9F4"
            >{post_time.format("DD/MM/YYYY - HH:MM")} ({post_time.fromNow()})</span
        >
        {post["id"] ? `(ID ${post["id"]})` : ""}
    </span>
    <div style="flex-grow: 1" />
    <slot />
</div>

<style>
    .info {
        display: flex;
        gap: 4px;
        color: gray;
        padding-bottom: 8px;
    }
</style>
