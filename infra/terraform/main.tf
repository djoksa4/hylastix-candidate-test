resource "azurerm_resource_group" "main" {
  name     = "${var.project_name}-rg"
  location = var.region
}

module "network" {
  source              = "./modules/network"
  project_name        = var.project_name
  region              = var.region
  resource_group_name = azurerm_resource_group.main.name
  address_space       = var.address_space
  subnets             = var.subnets
}

module "vms" {
  source              = "./modules/vms"
  project_name        = var.project_name
  region              = var.region
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = module.network.subnet_ids["private-runner-subnet"]

  runner_vm_size            = var.runner_vm_size
  runner_vm_admin_username  = var.runner_vm_admin_username
  runner_ssh_public_key     = var.runner_ssh_public_key
  runner_registration_token = var.runner_registration_token
  runner_github_url         = var.runner_github_url
}