#!/bin/sh
# --add-host olive.sfo.ouster.io:10.32.6.14 \
# --add-host host.docker.internal:host-gateway \
docker run --rm -ti --gpus all -e DISPLAY=$DISPLAY -e TERM=rxvt-unicode-256color \
    -v $HOME/container_data:/home/$USER/container_data \
    -v $HOME/container_data/.ccache:/home/$USER/.ccache \
    -v $HOME/.ssh:/home/$USER/.ssh \
    -v $HOME/workspace:/home/$USER/workspace \
    -v $HOME/data:/home/$USER/data \
    -v /dev:/dev \
    -e HISTFILE=/home/$USER/container_data/.zsh_history \
    --add-host host.docker.internal:host-gateway \
    --name $1 \
    --hostname $1 \
    $2 $3
