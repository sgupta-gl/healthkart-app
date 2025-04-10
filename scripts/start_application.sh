#!/bin/bash

# Define log file
LOG_FILE="/home/ec2-user/my-app/logs/start_application.log"
APP_DIR="/home/ec2-user/my-app"

# Ensure log directory exists
mkdir -p "$(dirname "$LOG_FILE")"
echo "Starting application: $(date)" | tee -a "$LOG_FILE"

# Navigate to app directory
cd "$APP_DIR" || {
    echo "App directory not found: $APP_DIR" | tee -a "$LOG_FILE"
    exit 1
}

# Stop and remove existing container if running
echo "Removing existing container (if any)..." | tee -a "$LOG_FILE"
docker rm -f node-app >> "$LOG_FILE" 2>&1

# Build the Docker image
echo "Building Docker image..." | tee -a "$LOG_FILE"
docker build -t node-app . >> "$LOG_FILE" 2>&1

# Run the container
echo "Starting Docker container..." | tee -a "$LOG_FILE"
docker run -d -p 3001:3001 --name node-app node-app >> "$LOG_FILE" 2>&1

# Confirm container started
if docker ps | grep -q node-app; then
    echo "Application started successfully in Docker container 'node-app'" | tee -a "$LOG_FILE"
else
    echo "Failed to start the application container" | tee -a "$LOG_FILE"
    exit 1
fi
