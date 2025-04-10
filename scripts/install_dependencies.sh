#!/bin/bash
# This script will install Docker on the EC2 instance

# Define log file
LOG_FILE="/home/ec2-user/app/logs/install_dependencies.log"
# Start logging
echo "Starting dependency installation: $(date)" 
echo "Updating package lists..." 
sudo yum update -y 

sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user  # Add ec2-user to docker group to run Docker without sudo
mkdir -p /home/ec2-user/app
cd /home/ec2-user/app
sudo npm install express