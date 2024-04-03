resource "azurerm_network_security_group" "example" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.rgname

  security_rule {
    name                       = "Allow_Inbound_HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.example.id
}