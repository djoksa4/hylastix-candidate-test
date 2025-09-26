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

  runner_vm_subnet_id       = module.network.subnet_ids["private-runner-subnet"]
  runner_vm_size            = var.runner_vm_size
  runner_vm_admin_username  = var.runner_vm_admin_username
  runner_vm_ssh_public_key  = var.runner_vm_ssh_public_key
  runner_registration_token = var.runner_registration_token
  runner_github_url         = var.runner_github_url

  app_vm_subnet_id      = module.network.subnet_ids["private-app-subnet"]
  app_vm_size           = var.app_vm_size
  app_vm_admin_username = var.app_vm_admin_username
  app_vm_ssh_public_key = var.app_vm_ssh_public_key
}

module "application_gateway" {
  source              = "./modules/application_gateway"
  project_name        = var.project_name
  region              = var.region
  resource_group_name = azurerm_resource_group.main.name
  appgw_subnet_id     = module.network.subnet_ids["appgw-subnet"]
  app_vm_private_ip   = module.vms.app_vm_private_ip
}