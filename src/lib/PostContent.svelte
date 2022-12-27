<script lang="ts">
    import ImageLoader from "./ImageLoader.svelte";

    export var board;
    export var post;

    function formatBytes(bytes, decimals = 2) {
        if (!+bytes) return "0 Bytes";

        const k = 1024;
        const dm = decimals < 0 ? 0 : decimals;
        const sizes = ["Bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];

        const i = Math.floor(Math.log(bytes) / Math.log(k));

        return `${parseFloat((bytes / Math.pow(k, i)).toFixed(dm))} ${
            sizes[i]
        }`;
    }
</script>

<div
    class="content"
    class:flex-wrap={post.com?.length >= 700 || (post.w > post.h && post.com?.length >= 250)}
>
    {#if post.tim}
        <a href="http://i.4cdn.org/{board}/{post.tim}{post.ext}" class="image">
            <ImageLoader
                src="http://localhost:8080/http://i.4cdn.org/{board}/{post.tim}s.jpg"
                placeholderWidth={post.tn_w}
                placeholderHeight={post.tn_h}
                alt={post.filename}
            />
        </a>
    {/if}

    <div>
        {#if post.tim}
            <a href="http://i.4cdn.org/{board}/{post.tim}{post.ext}" class="meta">
                {post.filename}{post.ext}
                ({formatBytes(post.fsize)})
                {#if post.w > 1 && post.h > 1}
                    ({post.w}x{post.h})
                {/if}
            </a>
        {/if}
        {#if post.sub != null}
            <div class="sub">{post.sub}</div>
        {/if}
        {#if post.com != null}
            <div class="com">{@html post.com}</div>
        {/if}

        <slot />
    </div>
</div>

<style>
    .content {
        display: flex;
        column-gap: 16px;
    }

    .flex-wrap {
        flex-wrap: wrap;
    }

    .sub {
        font-weight: bold;
    }

    .meta {
        color: gray;
    }
</style>
