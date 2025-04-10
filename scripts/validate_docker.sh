#!/bin/bash
echo "Validating Docker container..."
curl -s http://localhost:3001 || exit 1  # Adjust to your container's exposed port