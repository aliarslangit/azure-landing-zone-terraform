resource "azurerm_private_dns_zone" "example" {
  name                = var.dns_domain
  resource_group_name = var.rgname
}