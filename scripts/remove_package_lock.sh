#!/bin/bash

# Check if package-lock.json exists and remove it
FILE="/home/ec2-user/my-app/package-lock.json"
if [ -f "$FILE" ]; then
    echo "Removing existing package-lock.json"
    rm -f "$FILE"
else
    echo "No package-lock.json found, skipping removal."
fi
