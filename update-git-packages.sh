#!/bin/bash

# Set the repository path
REPO_PATH="/nexus-bucket/underground-nexus"

# Allow Git to treat the directory as safe
git config --global --add safe.directory "$REPO_PATH"

# Check ownership of the repository
OWNER=$(ls -ld "$REPO_PATH" | awk '{print $3}')

# Get the current user
CURRENT_USER=$(whoami)

# If the owner is different, change ownership
if [ "$OWNER" != "$CURRENT_USER" ]; then
    echo "Changing ownership to $CURRENT_USER..."
    sudo chown -R "$CURRENT_USER":"$CURRENT_USER" "$REPO_PATH"
fi

# Navigate to the repository and pull the latest changes
cd "$REPO_PATH" || { echo "Failed to navigate to $REPO_PATH"; exit 1; }
git pull origin main

echo "Repository updated successfully!" 