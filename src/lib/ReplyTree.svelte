<script lang="ts">
    import { onMount } from "svelte";
    import ReplyNode from "./ReplyNode.svelte";

    export var board;
    export var replies;
    var tree = [];
    
    const getTree = () => {
        var kv = {};

        for (var reply of replies) {
            reply = {...reply, children: new Set()}
            kv[reply.no] = reply

            if (reply.resto === 0) {
                tree.push(reply)
            } else {
                const com = (new DOMParser()).parseFromString(reply.com, "text/html")
                
                var childof = 0
                for (const link of com.getElementsByClassName("quotelink")) {
                    const num = parseInt(link.getAttribute('href').slice(2))
                    const parent = kv[num]

                    if (parent == null) {
                        console.log(`unknown parent of ${reply.no} with number ${num}`)
                        continue
                    }
                    
                    parent.children.add(reply)
                    childof++
                }

                if (!childof) {
                    kv[reply.resto].children.add(reply)
                }
            }
        }

        return tree
    }
</script>

<ReplyNode board={board} reply={getTree()[0]} onlyChildren>
</ReplyNode>