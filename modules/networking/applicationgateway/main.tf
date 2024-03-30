locals {
  backend_address_pool_name      = "backendpool1"
  frontend_port_name             = "feport1"
  frontend_ip_configuration_name = "frontendipconfig1"
  http_setting_name              = "httpsetting1"
  listener_name                  = "httplistener1"
  request_routing_rule_name      = "routingrule1"
  redirect_configuration_name    = "redirectconfigname"
}

resource "azurerm_application_gateway" "network" {
  name                = var.appgwname
  resource_group_name = var.rgname
  location            = var.location

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.sku_capacity
  }

  gateway_ip_configuration {
    name      = "${var.appgwname}-ip-configuration"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = local.frontend_port_name
    port = var.frontend_port
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = var.pip_id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = var.backend_port
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}