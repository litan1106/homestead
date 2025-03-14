#!/usr/bin/env bash

if [ -f ~/.homestead-features/wsl_user_name ]; then
    WSL_USER_NAME="$(cat ~/.homestead-features/wsl_user_name)"
    WSL_USER_GROUP="$(cat ~/.homestead-features/wsl_user_group)"
else
    WSL_USER_NAME=vagrant
    WSL_USER_GROUP=vagrant
fi

export DEBIAN_FRONTEND=noninteractive

PATH_NGROK="/home/$WSL_USER_NAME/.config/ngrok"
PATH_CONFIG="${PATH_NGROK}/ngrok.yml"

# Only create a ngrok config file if there isn't one already there.
if [ ! -f $PATH_CONFIG ]; then
    mkdir -p "$PATH_NGROK"
    cat > "$PATH_CONFIG" << EOF
version: 2
web_addr: $1:4040
EOF
fi
