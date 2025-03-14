#!/usr/bin/env bash

if [ -f ~/.homestead-features/wsl_user_name ]; then
    WSL_USER_NAME="$(cat ~/.homestead-features/wsl_user_name)"
    WSL_USER_GROUP="$(cat ~/.homestead-features/wsl_user_group)"
else
    WSL_USER_NAME=vagrant
    WSL_USER_GROUP=vagrant
fi

export DEBIAN_FRONTEND=noninteractive

mkdir /home/$WSL_USER_NAME/ecosystem 2>/dev/null

PATH_ECOSYSTEM="/home/$WSL_USER_NAME/ecosystem"

rm -rf /home/$WSL_USER_NAME/ecosystem/*

PATH_JSON="${PATH_ECOSYSTEM}/${1}.json"

# variables
# 1 = name
# 2 = script
# 3 = args
# 4 = path

BASE_ECO='
{
  "name": "'$1'",
  "script": "'$2'",
  "args": "'$3'",
  "cwd": "'$4'"
}
'

# Only generate a ecosystem if there isn't one already there.
if [ ! -f $PATH_JSON ]
then
    echo "$BASE_ECO" > $PATH_JSON
fi
