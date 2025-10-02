# HYLASTIX-CANDIDATE-TEST

## Architecture
- Remote Terraform backend (in an Azure Blob)
- Azure VNET
- 3 subnets:
  - App VM subnet
  - GitHub self-hosted runner VM subnet
  - Application Gateway subnet
- private VM for GitHub self-hosted runner with an init script that sets up the runner (this enables the app VM to stay private and still be configurable from GitHub workflow)
- private VM for the app to run on (assosicated NSG allowing access from Application Gateway only on port 8080)
- An Application Gateway reachable on public IP on port 80, targeting the app VM as its backend available on port 8080
- fully configured through Terraform in a way that enables easy expansion, changing parameters and adding new features

## Deployment
- Two GitHub workflows (1 for one-click deployment, 1 for disassembly).
- All parameters passed as vars and secrets (configurable in one place).
- Deployment workflow will:
  1. Generate a token for registering a GitHub self-hosted runner.
  2. Deploy complete infrastructure using Terraform.
  3. Run the next job on the new self-hosted runner on a private VM in Azure.
  4. Run Ansible playbooks against the private app VM (possible because both runner VM and app VM are in same VNET).
  5. Ansible playbooks will setup Docker, ensure Docker service is running and setup Docker network.
  6. Ansible playbooks will also deploy an **nginx** container (webserver) mapped to host (VM) port 8080 for Application Gateway to target, and **Keycloak**, **oauth2-proxy** and **Postgres** containers (and necessary configuration) in order to control static webpage access.

## Justification
- Images used on the VMs are lightweight, no other reasoning behind it since this is a simple assignment.
- The network is designed in a way to keep the app VM private and expose only the webserver port (through the Application Gateway).  
Running Anisible playbooks on a private VM is backed by using a self-hosted GitHub runner in another VM in the same VNET.

## Future Improvements
- Caching Ansible roles in the GitHub workflow would optimize the deployment run time.
- Could potentially move from Docker to containerd for the container environment (more lightweight - if the project allows).
- Could potentially move away from using ready-made Ansible roles (Ansible code more complex but would provide more control).
- Right now Keycloak Postgres DB isn’t persisted anywhere (since this is just an assignment) but should be in a real-life project.
- Should run Keycloak in prod mode (right now it’s running in dev because I didn’t want to deal with HTTPS).