resource "azurerm_firewall" "example" {
  name                = var.firewallname
  location            = var.location
  resource_group_name = var.rgname
  sku_name            = var.sku_name
  sku_tier            = var.sku_tier

  ip_configuration {
    name                 = "ipconfiguration"
    subnet_id            = var.subnet_id
    public_ip_address_id = var.public_ip_id
  }
}