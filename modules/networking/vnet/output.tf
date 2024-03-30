output "vnet_name" {
  value = azurerm_virtual_network.example.name
}

output "vnet_id" {
  value = azurerm_virtual_network.example.id
}

output "subnet_ids" {
  value = {
    for subnet_key, subnet_value in azurerm_virtual_network.example.subnet : subnet_value.name => subnet_value.id
  }
}