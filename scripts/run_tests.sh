#!/bin/bash
cd /home/ec2-user/app
echo "Running tests..."
npm test  # Or any command you use to run your tests (e.g., `jest`, `mocha`)
if [ $? -eq 0 ]; then
  echo "Tests passed."
else
  echo "Tests failed."
  exit 1  # This will fail the deployment if tests fail
fi
