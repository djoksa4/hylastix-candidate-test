#!/bin/bash

RUNNER_TOKEN="${runner_token}"
GITHUB_URL="${github_url}"
RUNNER_NAME="${runner_name}"

# Install dependencies
apt-get update
apt-get install -y curl jq git

# Ensure /home/azureuser/actions-runner exists
mkdir -p /home/azureuser/actions-runner
chown -R azureuser:azureuser /home/azureuser/actions-runner

# Switch to azureuser for all runner commands
su - azureuser -c "
cd /home/azureuser/actions-runner


# Download the specific runner version
curl -O -L https://github.com/actions/runner/releases/download/v2.328.0/actions-runner-linux-x64-2.328.0.tar.gz

# Extract the runner
tar xzf ./actions-runner-linux-x64-2.328.0.tar.gz

# Configure the runner (unattended)
./config.sh --url \"$GITHUB_URL\" --token \"$RUNNER_TOKEN\" --name \"$RUNNER_NAME\" --unattended --replace

# Install and start the runner service
./svc.sh install
./svc.sh start
"