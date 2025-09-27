#!/bin/bash

RUNNER_TOKEN="${runner_token}"
GITHUB_URL="${github_url}"
RUNNER_NAME="${runner_name}"

# Install dependencies
apt-get update
apt-get install -y curl jq git

# Ensure user directory exists
RUNNER_DIR="/home/azureuser/actions-runner"
mkdir -p "$RUNNER_DIR"
cd "$RUNNER_DIR"

# Download the latest GitHub runner
curl -o actions-runner-linux-x64.tar.gz -L https://github.com/actions/runner/releases/latest/download/actions-runner-linux-x64.tar.gz
tar xzf actions-runner-linux-x64.tar.gz

# Make scripts executable
chmod +x config.sh svc.sh

# Configure the runner
sudo -u azureuser ./config.sh --url "$GITHUB_URL" --token "$RUNNER_TOKEN" --name "$RUNNER_NAME" --unattended --replace

# Install as a service
sudo -u azureuser ./svc.sh install
sudo -u azureuser ./svc.sh start