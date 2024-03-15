resource "azurerm_virtual_network" "example" {
  name                = var.vnetname
  location            = var.location
  resource_group_name = var.rgname
  address_space       = var.vnet_addresspaces
  dns_servers         = var.dns_servers
}

resource "azurerm_subnet" "subnets" {
  for_each  = var.subnets
  name      = each.key
  address_prefixes = [each.value]
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.rgname
}