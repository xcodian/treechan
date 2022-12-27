#!/bin/env bash

# Change me to whatever you want!
PORT=8080

# --------------------------------------------

REPO_ROOT=$(git rev-parse --show-toplevel)

if [ ! -d $REPO_ROOT/dist ]; then 
    echo "Building HTML, JS & CSS files from Svelte..."
    docker run -it --rm \
               -v $REPO_ROOT:/mnt \
               -w /mnt -u node \
               node:18 sh -c "yarn; yarn build"
fi

if [ $(docker ps -a -f name=treechan | wc -l) -eq 2 ]; then
    echo "Treechan is already running:"
    echo ""
    docker ps -a -f name=treechan
    echo ""
    echo "To stop it, run:"
    echo "  docker stop treechan"
    echo ""
else
    echo "Starting container..."

    docker run \
        -it --rm \
        --name treechan \
        -v $REPO_ROOT/nginx/config/nginx.conf:/etc/nginx/nginx.conf:ro \
        -v $REPO_ROOT/nginx/config/conf.d:/etc/nginx/conf.d:ro \
        -v $REPO_ROOT/dist:/usr/share/nginx/html:ro \
        -p $PORT:80 \
        -d \
        nginx

    echo "Treechan started on port $PORT!"
    echo ""
    echo "View logs:"
    echo "  docker logs treechan"
    echo "Stop treechan:"
    echo "  docker stop treechan"
    echo ""
fi
