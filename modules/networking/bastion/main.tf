resource "azurerm_bastion_host" "demo" {
  name                = var.bastionhostname
  location            = var.location
  resource_group_name = var.rgname

  ip_configuration {
    name                 = "Bastion_IP_Configuration"
    subnet_id            = var.subnet_id
    public_ip_address_id = var.pip_id
  }
}