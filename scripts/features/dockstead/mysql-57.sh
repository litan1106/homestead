#!/usr/bin/env bash

if [ -f ~/.homestead-features/wsl_user_name ]; then
    WSL_USER_NAME="$(cat ~/.homestead-features/wsl_user_name)"
    WSL_USER_GROUP="$(cat ~/.homestead-features/wsl_user_group)"
else
    WSL_USER_NAME=vagrant
    WSL_USER_GROUP=vagrant
fi
echo $WSL_USER_NAME:$WSL_USER_GROUP

# Stop the default MySQL Service
sudo service mysql stop

# Update .my.cnf
sed -i "s/localhost/127.0.0.1/" /home/$WSL_USER_NAME/.my.cnf

# Start the MySQL 5.7 stack
docker stack deploy -c /$WSL_USER_NAME/scripts/features/dockstead/mysql-5.7.yaml mysql-57
echo "Sleeping for 30 seconds while we wait for MySQL service to come up"
sleep 30
