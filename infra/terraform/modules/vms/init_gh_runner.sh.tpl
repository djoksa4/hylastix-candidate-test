#!/bin/bash

# Variables passed via templatefile
RUNNER_TOKEN="${runner_token}"
GITHUB_URL="${github_url}"
RUNNER_NAME="${runner_name}"

# Install dependencies
apt-get update
apt-get install -y curl jq git

# Create a directory for the runner
mkdir -p /home/azureuser/actions-runner
cd /home/azureuser/actions-runner

# Download the latest GitHub runner
curl -o actions-runner-linux-x64.tar.gz -L https://github.com/actions/runner/releases/latest/download/actions-runner-linux-x64.tar.gz
tar xzf ./actions-runner-linux-x64.tar.gz

# Configure the runner
./config.sh --url "$GITHUB_URL" --token "$RUNNER_TOKEN" --name "$RUNNER_NAME" --unattended --replace

# Install as a service
./svc.sh install
./svc.sh start