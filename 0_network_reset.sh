#!/bin/bash

echo "Stopping all containers..."
# Stops all running containers
docker stop $(docker ps -aq)

echo "Waiting for containers to fully stop..."
# Waits for 5 seconds to ensure all containers have stopped
sleep 5

echo "Removing all containers..."
# Removes all stopped containers
docker rm $(docker ps -aq)

echo "Removing unused Docker volumes..."
# Force removal of all unused volumes
docker volume prune -f


sudo systemctl restart docker
echo "Network reset complete."

echo "Deleting directories from previous run"
root_dir="/tmp/hyperledger"

# Ensure the root directory exists
if [ -d "$root_dir" ]; then
    # Find all files and delete them
    sudo find "$root_dir" -type f -exec rm -f {} \;

    # Find all subdirectories but preserve the structure by not deleting the directories themselves
    sudo find "$root_dir" -mindepth 1 -type d -exec rm -rf {}/* \;

    echo "Contents of $root_dir have been deleted but the directory structure is preserved."
else
    echo "Directory $root_dir does not exist."
fi
