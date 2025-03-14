#!/usr/bin/env bash

if [ -f ~/.homestead-features/wsl_user_name ]; then
    WSL_USER_NAME="$(cat ~/.homestead-features/wsl_user_name)"
    WSL_USER_GROUP="$(cat ~/.homestead-features/wsl_user_group)"
else
    WSL_USER_NAME=vagrant
    WSL_USER_GROUP=vagrant
fi

export DEBIAN_FRONTEND=noninteractive

if [ ! -d /etc/cron.d ]; then
    mkdir /etc/cron.d
fi

SITE_DOMAIN=$1
SITE_PUBLIC_DIRECTORY=$2
SITE_PHP_VERSION=$3

cron="* * * * * $WSL_USER_NAME  . /home/$WSL_USER_NAME/.profile; /usr/bin/php$SITE_PHP_VERSION $SITE_PUBLIC_DIRECTORY/../artisan schedule:run >> /dev/null 2>&1"

echo "$cron" > "/etc/cron.d/$SITE_DOMAIN"
