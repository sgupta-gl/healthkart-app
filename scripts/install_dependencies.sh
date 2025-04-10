#!/bin/bash
# This script will install Docker on the EC2 instance

# Define log file
mkdir -p /home/ec2-user/app/logs
LOG_FILE="/home/ec2-user/app/logs/install_dependencies.log"
# Start logging
echo "Starting dependency installation: $(date)" >> $LOG_FILE
echo "Updating package lists..." >> $LOG_FILE
sudo yum update -y >> $LOG_FILE 2>&1

sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user  # Add ec2-user to docker group to run Docker without sudo
cd /home/ec2-user/app
sudo npm install express