resource "azurerm_lb" "main" {
  name                = var.lbname
  location            = var.location
  resource_group_name = var.rgname
  sku                 = var.sku
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = var.public_ip_id
  }

}
resource "azurerm_lb_backend_address_pool" "main" {
  loadbalancer_id     = azurerm_lb.main.id
  for_each            = toset(var.backendpools)
  name                = each.key
}
resource "azurerm_lb_rule" "main" {
  count                          = length(var.lbrules)
  loadbalancer_id                = azurerm_lb.main.id
  name                           = "LBRule-${count.index}"
  protocol                       = "Tcp"
  frontend_port                  = lookup(element(var.lbrules, count.index), "frontendport")
  backend_port                   = lookup(element(var.lbrules, count.index), "backendport")
  frontend_ip_configuration_name = "PublicIPAddress"
  idle_timeout_in_minutes  = 5
}