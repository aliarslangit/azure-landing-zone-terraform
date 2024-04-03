module "rg" {
  source = "./modules/networking/rg"
  rgname = "Lab-RG"
  location = "eastus"
}
module "azure-vnet1" {
    source = "./modules/networking/vnet"
    vnetname = "vnet1"
    location = "eastus"
    rgname = module.rg.resource_group_name
    subnets = [
    {
      name           = "subnet1"
      address_prefix = "10.0.1.0/24"
    },
    {
      name           = "AzureFirewallSubnet"
      address_prefix = "10.0.2.0/24"
    },
  ]
    vnet_addresspaces = ["10.0.0.0/16"]
}

module "azure-vnet2" {
    source = "./modules/networking/vnet"
    vnetname = "vnet2"
    location = "eastus"
    rgname = module.rg.resource_group_name
    subnets = [
    {
      name           = "subnet1"
      address_prefix = "192.168.2.0/24"
    },
    {
      name           = "subnet2"
      address_prefix = "192.168.1.0/24"
    },
  ]
    vnet_addresspaces = ["192.168.0.0/16"]
}

module "vnet-peer" {
  source = "./modules/networking/vnetpeering"
  rgname = module.rg.resource_group_name
  vnet1_id = module.azure-vnet1.vnet_id
  vnet1_name = module.azure-vnet1.vnet_name
  vnet2_id = module.azure-vnet2.vnet_id
  vnet2_name = module.azure-vnet2.vnet_name
}
module "lb_pip" {
  source = "./modules/networking/publicip"
  pip_name = "lbpip"
  rgname = module.rg.resource_group_name
  location = "eastus"
  allocation_method = "Static"
  sku = "Standard"
}
module "fw_pip" {
  source = "./modules/networking/publicip"
  pip_name = "fwpip"
  rgname = module.rg.resource_group_name
  location = "eastus"
  allocation_method = "Static"
  sku = "Standard"
}
module "appgw_pip" {
  source = "./modules/networking/publicip"
  pip_name = "appgwpip"
  rgname = module.rg.resource_group_name
  location = "eastus"
  allocation_method = "Static"
  sku = "Standard"
}
module "lb" {
  source = "./modules/networking/loadbalancer"
  rgname = module.rg.resource_group_name
  lbname = "lb1"
  location = "eastus"
  public_ip_id = module.lb_pip.pip_id 
  sku = "Standard"
  backendpools = ["backendpool1","backendpool2"]

}

module "cdn" {
  source = "./modules/networking/cdn"
  profilename = "cdnprofile1"
  rgname = module.rg.resource_group_name
  location = "eastus"
  sku = "Standard_Verizon"
  host_name = module.lb_pip.pip
}

module "firewall" {
  source = "./modules/networking/firewall"
  rgname = module.rg.resource_group_name
  firewallname = "firewall1"
  location = "eastus"
  sku_name = "AZFW_VNet"
  sku_tier = "Standard"
  public_ip_id = module.fw_pip.pip_id
  subnet_id = module.azure-vnet1.subnet_ids["AzureFirewallSubnet"]
}

module "trafficmanager" {
  source = "./modules/networking/trafficmanager"
  rgname = module.rg.resource_group_name
  location = "eastus"
  tfname = "trafficmanagertierpointdev"
  protocol = "HTTP"
  port = 80
  path = "/"
  interval = 30
  timeout = 9
  number_of_failures = 3
  routingmethod = "Weighted"
  target_pip_id = module.lb_pip.pip_id
  weight = 100
  }

  module "ddos" {
    source = "./modules/networking/ddos"
    rgname = module.rg.resource_group_name
    location = "eastus"
    ddosname = "tierpointddos"    
  }

  module "frontdoor" {
  source = "./modules/networking/frontdoor"
  name = "tierpointdevfrontdoor"
  rgname = module.rg.resource_group_name
  backend_name = "exampleBackend"
  backend_hostname = "www.bing.com"
  frontend_name = "tierpointdevfrontdoorFrontendEndpoint"
  frontend_hostname = "tierpointdevfrontdoor.azurefd.net"
}

module "appgw" {
  source = "./modules/networking/applicationgateway"
  rgname = module.rg.resource_group_name
  appgwname = "tierpoint-appgateway"
  location = "eastus"
  frontend_port = 80
  backend_port = 80
  pip_id = module.appgw_pip.pip_id
  sku_name = "Standard_v2"
  sku_tier = "Standard_v2"
  sku_capacity = "2"
  subnet_id = module.azure-vnet1.subnet_ids["subnet1"]
}

module "nsg" {
  source = "./modules/networking/nsg"
  nsg_name = "vnetnsg"
  rgname = module.rg.resource_group_name
  location = "eastus"
  subnet_id =  module.azure-vnet1.subnet_ids["subnet1"]
}

module "dns" {
  source = "./modules/networking/privatedns"
  dns_domain = "www.tierpoint.com"
  rgname = module.rg.resource_group_name
}