resource "azurerm_frontdoor" "example" {
  name                = var.name
  resource_group_name = var.rgname
 backend_pool {
    name = var.backend_name
    backend {
      host_header = var.backend_hostname
      address     = var.backend_hostname
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "exampleLoadBalancingSettings1"
    health_probe_name   = "exampleHealthProbeSetting1"
  }
  routing_rule {
    name               = "exampleRoutingRule1"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = [var.frontend_name]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = var.backend_name
    }
  }

  backend_pool_load_balancing {
    name = "exampleLoadBalancingSettings1"
  }

  backend_pool_health_probe {
    name = "exampleHealthProbeSetting1"
  }

 

  frontend_endpoint {
    name      = var.frontend_name
    host_name = var.frontend_hostname
  }
}