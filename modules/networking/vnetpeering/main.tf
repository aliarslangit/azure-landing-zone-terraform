resource "azurerm_virtual_network_peering" "vnet1-vnet2" {
  name                      = "peer1to2"
  resource_group_name       = var.rgname
  virtual_network_name      = var.vnet1_name
  remote_virtual_network_id = var.vnet2_id
}

resource "azurerm_virtual_network_peering" "vnet2-vnet1" {
  name                      = "peer2to1"
  resource_group_name       = var.rgname
  virtual_network_name      = var.vnet2_name
  remote_virtual_network_id = var.vnet1_id
}