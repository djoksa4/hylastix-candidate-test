################ VNET ################
resource "azurerm_virtual_network" "this" {
  name                = "${var.project_name}-vnet"
  location            = var.region
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}

################ SUBNETS ################
resource "azurerm_subnet" "this" {
  for_each             = { for s in var.subnets : s.name => s }
  name                 = each.value.name
  address_prefixes     = [each.value.address_prefix]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
}
