resource "azurerm_traffic_manager_profile" "example" {
  name                   = var.tfname
  resource_group_name    = var.rgname
  traffic_routing_method = var.routingmethod

  dns_config {
    relative_name = "${var.tfname}-profile"
    ttl           = 100
  }

  monitor_config {
    protocol                     = "HTTP"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = var.interval
    timeout_in_seconds           = var.timeout
    tolerated_number_of_failures = var.number_of_failures
  }

}

resource "azurerm_traffic_manager_azure_endpoint" "example" {
  name                 = "${var.tfname}-endpoint"
  profile_id           = azurerm_traffic_manager_profile.example.id
  weight               = var.weight
  target_resource_id   = var.target_pip_id
}