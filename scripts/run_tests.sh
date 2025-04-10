#!/bin/bash

# Define log file
LOG_FILE="/home/ec2-user/my-app/logs/run_tests.log"
APP_DIR="/home/ec2-user/my-app"

# Ensure the log directory exists
mkdir -p "$(dirname "$LOG_FILE")"

# Start logging
echo "Running tests: $(date)" | tee -a "$LOG_FILE"

# Change to app directory
cd "$APP_DIR" || {
  echo "ERROR: Failed to cd into $APP_DIR" | tee -a "$LOG_FILE"
  exit 1
}

# Run the test command
echo "Executing tests..." | tee -a "$LOG_FILE"
npm test >> "$LOG_FILE" 2>&1

# Check exit code
if [ $? -eq 0 ]; then
  echo "✅ Tests passed successfully." | tee -a "$LOG_FILE"
else
  echo "❌ Tests failed!" | tee -a "$LOG_FILE"
  exit 1  # Fails the deployment
fi
