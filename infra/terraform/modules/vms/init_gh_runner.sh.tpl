#!/bin/bash

# Install dependencies
apt-get update
apt-get install -y curl jq git

# Ensure actions-runner dir
mkdir -p /home/azureuser/actions-runner
chown -R azureuser:azureuser /home/azureuser/actions-runner

# Download and configure runner as azureuser
sudo -i -u azureuser bash <<EOF
cd /home/azureuser/actions-runner
curl -O -L https://github.com/actions/runner/releases/download/v2.328.0/actions-runner-linux-x64-2.328.0.tar.gz
tar xzf ./actions-runner-linux-x64-2.328.0.tar.gz
./config.sh --url "${github_url}" --token "${runner_token}" --name "${runner_name}" --unattended --replace
EOF

# Install & start service as root
cd /home/azureuser/actions-runner
./svc.sh install
./svc.sh start
