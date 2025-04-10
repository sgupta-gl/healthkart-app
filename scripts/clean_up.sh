#!/bin/bash
# This script will clean up any old containers
docker stop node-app
docker rm node-app