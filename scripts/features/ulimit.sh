#!/usr/bin/env bash

if [ -f ~/.homestead-features/wsl_user_name ]; then
    WSL_USER_NAME="$(cat ~/.homestead-features/wsl_user_name)"
    WSL_USER_GROUP="$(cat ~/.homestead-features/wsl_user_group)"
else
    WSL_USER_NAME=vagrant
    WSL_USER_GROUP=vagrant
fi
echo $WSL_USER_NAME:$WSL_USER_GROUP

export DEBIAN_FRONTEND=noninteractive

if [ -f /home/$WSL_USER_NAME/.homestead-features/ulimit ]
then
    echo "ulimit already installed."
    exit 0
fi

touch /home/$WSL_USER_NAME/.homestead-features/ulimit
chown -Rf $WSL_USER_NAME:$WSL_USER_GROUP /home/$WSL_USER_NAME/.homestead-features

touch /home/$WSL_USER_NAME/.homestead-features/ulimit65536
chown -Rf $WSL_USER_NAME:$WSL_USER_GROUP /home/$WSL_USER_NAME/.homestead-features

echo "soft nofile 65536" > "/etc/security/limits.conf"
echo "hard nofile 65536" > "/etc/security/limits.conf"
