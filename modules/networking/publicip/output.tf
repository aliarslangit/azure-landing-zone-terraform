output "pip_id" {
  value = azurerm_public_ip.example.id
}

output "pip" {
  value = azurerm_public_ip.example.ip_address
}