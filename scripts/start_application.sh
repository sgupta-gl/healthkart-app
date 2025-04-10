#!/bin/bash
# Define log file
mkdir -p /home/ec2-user/app/logs
LOG_FILE="/home/ec2-user/app/logs/start_application.log"

# Start logging
echo "Starting application: $(date)" >> $LOG_FILE

# This script builds and starts the Docker container with your app
cd /home/ec2-user/app
# Remove any previous container (if it exists) to avoid conflicts
docker rm -f node-app >> "$LOG_FILE" 2>&1
docker build -t node-app . >> "$LOG_FILE" 2>&1
docker run -d -p 3001:3001 --name node-app node-app >> "$LOG_FILE" 2>&1