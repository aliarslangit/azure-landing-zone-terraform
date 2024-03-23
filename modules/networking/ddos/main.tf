resource "azurerm_network_ddos_protection_plan" "example" {
  name                = var.ddosname
  location            = var.location
  resource_group_name = var.rgname
}