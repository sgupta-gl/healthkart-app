#!/bin/bash

# This script installs Docker, Node.js, and app dependencies on the EC2 instance

# Define log file
LOG_FILE="/home/ec2-user/app/logs/install_dependencies.log"
APP_DIR="/home/ec2-user/app"

# Ensure log directory exists
mkdir -p "$(dirname "$LOG_FILE")"
echo "Starting dependency installation: $(date)" | tee -a "$LOG_FILE"

# Update packages
echo "Updating system packages..." | tee -a "$LOG_FILE"
sudo yum update -y >> "$LOG_FILE" 2>&1

# Install Docker
echo "Installing Docker..." | tee -a "$LOG_FILE"
sudo yum install -y docker >> "$LOG_FILE" 2>&1
sudo systemctl start docker
sudo usermod -aG docker ec2-user

# Ensure app directory exists
echo "Ensuring app directory exists..." | tee -a "$LOG_FILE"
mkdir -p "$APP_DIR"
cd "$APP_DIR" || {
    echo "Failed to cd into $APP_DIR" | tee -a "$LOG_FILE"
    exit 1
}

# Check if npm is installed, install Node.js if not
if ! command -v npm &> /dev/null; then
    echo "npm not found. Installing Node.js and npm..." | tee -a "$LOG_FILE"
    curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash - >> "$LOG_FILE" 2>&1
    sudo yum install -y nodejs >> "$LOG_FILE" 2>&1
else
    echo "npm is already installed" | tee -a "$LOG_FILE"
fi

# Install Express
echo "Installing Express..." | tee -a "$LOG_FILE"
sudo npm install express >> "$LOG_FILE" 2>&1

echo "Dependency installation complete: $(date)" | tee -a "$LOG_FILE"
