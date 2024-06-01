#!/bin/bash

# Define the directory containing the scripts
SCRIPTS_DIR="/home/cyprian/Desktop/Hyperledger_network/Scripts"

# Paths to replace
declare -A PATHS_TO_REPLACE=(
    ["/home/cyprian/Desktop/Hyperledger_network/Configuration"]='${CONFIGURATION_PATH}'
    ["/home/cyprian/Desktop/Hyperledger_network/Docker_files"]='${DOCKER_PATH}'
    ["/home/cyprian/Desktop/Hyperledger_network/ConfigTx"]='${CONFIGTX_PATH}'
)

# Loop through each file and replace paths
for file in $(find "$SCRIPTS_DIR" -type f -name "*.sh"); do
    echo "Processing $file"
    for path in "${!PATHS_TO_REPLACE[@]}"; do
        replacement=${PATHS_TO_REPLACE[$path]}
        sed -i "s|${path}|${replacement}|g" "$file"
    done
done

echo "Path replacement complete."
