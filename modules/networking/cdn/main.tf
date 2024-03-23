resource "azurerm_cdn_profile" "example" {
  name                = var.profilename
  location            = var.location
  resource_group_name = var.rgname
  sku                 = var.sku

}

# Create CDN Endpoint
resource "azurerm_cdn_endpoint" "example" {
  name                = "${var.profilename}-endpoint"
  profile_name        = var.profilename
  location            = var.location
  resource_group_name = var.rgname

  origin {
    name       = "example"
    host_name  = var.host_name
    http_port  = "80"
    https_port = "443"
  }

  origin_host_header = var.host_header
}