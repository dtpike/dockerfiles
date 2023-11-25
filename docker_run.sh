#!/bin/sh
docker run --rm -ti -e DISPLAY=$DISPLAY -e TERM=rxvt-unicode-256color \
    -v $HOME/container_data:/home/user/container_data \
    -v $HOME/container_data/.ccache:/home/user/.ccache \
    -v $HOME/.ssh:/home/user/.ssh \
    -v $HOME/.conan:/home/user/.conan \
    -v $HOME/workspace:/home/user/workspace \
    -v /dev:/dev \
    --add-host olive.sfo.ouster.io:10.32.6.14 \
    -e HISTFILE=/home/user/container_data/.zsh_history \
    --add-host host.docker.internal:host-gateway \
    --name $1 \
    --hostname $1 \
    $2 $3
