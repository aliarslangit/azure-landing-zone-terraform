resource "azurerm_public_ip" "example" {
  name                = var.pip_name
  location            = var.location
  resource_group_name = var.rgname
  allocation_method   = var.allocation_method  # or "Static" if you want a static IP
  sku = var.sku
}