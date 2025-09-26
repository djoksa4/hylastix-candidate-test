output "appgw_public_ip" {
  description = "Public IP of the Application Gateway"
  value = azurerm_public_ip.appgw_pip.ip_address
}