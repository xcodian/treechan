<script lang="ts">
    import { tick } from "svelte";
    import BoardList from "./lib/BoardList.svelte";
    import Catalog from "./lib/Catalog.svelte";
    import { nsfw_model } from "./lib/stores";

    let board = null;
    let model_loading = false;
    let model;

    async function load_model() {
        model_loading = true;
        await tick();

        const nsfwjs = await import("nsfwjs");
        const tf = await import("@tensorflow/tfjs");
        
        tf.enableProdMode();
        model = await nsfwjs.load("/nsfw_model/", { size: 299 });
        nsfw_model.set(model);
        model_loading = false;
    }

    async function toggle_model() {
        if ($nsfw_model == null) {
            if (model != null) {
                nsfw_model.set(model);
                return;
            }
            await load_model();
            return;
        }

        nsfw_model.set(null);
    }
</script>

<main class:mtop={board == null}>
    <span class="title">treechan</span>
    <span class="subtitle">Tree-based based 4chan client</span>

    <div>
        <!-- svelte-ignore a11y-click-events-have-key-events -->
        <div class="nsfwmodel-toggle" on:click={toggle_model}>
            Blur NSFW images with AI:
            {#if model_loading}
                <span style="color: yellow;">Loading</span>
            {:else if !$nsfw_model}
                <span style="color: red;">Off</span>
            {:else}
                <span style="color: greenyellow">On</span>
            {/if}
            {#if model != null || $nsfw_model != null}
                <span class="nsfwmodel-inmem">
                    &nbsp;(AI Model loaded in memory)
                </span>
            {/if}
        </div>

        {#if model_loading}
            <div class="nsfwmodel-loading">
                Please wait while the NSFW AI model loads (this may take a few
                seconds)...
            </div>
        {/if}
    </div>

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

    .nsfwmodel-toggle {
        background-color: rgba(0, 0, 0, 0.25);
        max-width: fit-content;
        padding: 0.5em;
        border-radius: 8px;
        cursor: pointer;
    }

    .nsfwmodel-inmem {
        color: gray;
    }

    .nsfwmodel-loading {
        color: yellow;
        max-width: fit-content;
        padding: 8px;
        border-radius: 8px;
        border: 2px solid yellow;
        margin-top: 16px;
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
