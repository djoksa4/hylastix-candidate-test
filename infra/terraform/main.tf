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