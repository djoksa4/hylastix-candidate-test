################ APPLICATION GATEWAY ################
resource "azurerm_public_ip" "appgw_pip" {
  name                = "${var.project_name}-appgw-pip"
  location            = var.region
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "this" {
  name                = "${var.project_name}-appgw"
  location            = var.region
  resource_group_name = var.resource_group_name

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "appgw-ipcfg"
    subnet_id = var.appgw_subnet_id
  }

  # frontend
  frontend_port {
    name = "http"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "appgw-feip"
    public_ip_address_id = azurerm_public_ip.appgw_pip.id
  }

  http_listener {
    name                           = "listener"
    frontend_ip_configuration_name = "appgw-feip"
    frontend_port_name             = "http"
    protocol                       = "Http"
  }

  # backend
  backend_address_pool {
    name = "app-backend-pool"
    ip_addresses = [var.app_vm_private_ip]
  }

  backend_http_settings {
    name                  = "app-http-settings"
    port                  = 8080
    protocol              = "Http"
    cookie_based_affinity = "Disabled"
    request_timeout       = 30
  }

  request_routing_rule {
    name                       = "app-rule"
    rule_type                  = "Basic"
    http_listener_name         = "listener"
    backend_address_pool_name  =  "app-backend-pool"
    backend_http_settings_name = "app-http-settings"
  }
}