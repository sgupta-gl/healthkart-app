#!/bin/bash
# Define log file
LOG_FILE="/home/ec2-user/app/logs/start_application.log"

# Start logging
echo "Starting application: $(date)" 

# This script builds and starts the Docker container with your app
cd /home/ec2-user/app
# Remove any previous container (if it exists) to avoid conflicts
docker rm -f node-app
docker build -t node-app . 
docker run -d -p 3001:3001 --name node-app node-app