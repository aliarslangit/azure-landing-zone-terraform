module "azure-vnet1" {
    source = "./modules/networking/vnet"
    vnetname = "vnet1"
    location = "eastus"
    rgname = "rg1"
    subnets = [
    {
      name           = "subnet1"
      address_prefix = "10.0.1.0/24"
    },
    {
      name           = "subnet2"
      address_prefix = "10.0.2.0/24"
    },
  ]
    vnet_addresspaces = ["10.0.0.0/8"]
}

module "azure-vnet2" {
    source = "./modules/networking/vnet"
    vnetname = "vnet2"
    location = "eastus"
    rgname = "rg1"
    subnets = [
    {
      name           = "subnet1"
      address_prefix = "10.0.1.0/24"
    },
    {
      name           = "subnet2"
      address_prefix = "10.0.2.0/24"
    },
  ]
    vnet_addresspaces = ["10.0.0.0/8"]
}

module "vnet-peer" {
  source = "./modules/networking/vnetpeering"
  rgname = "rg1"
  vnet1_id = module.azure-vnet1.vnet_id
  vnet1_name = module.azure-vnet1.vnet_name
  vnet2_id = module.azure-vnet2.vnet_id
  vnet2_name = module.azure-vnet2.vnet_name
}
module "pip" {
  source = "./modules/networking/publicip"
  pip_name = "pip1"
  rgname = "rg1"
  location = "eastus"
  allocation_method = "Static"
  sku = "Standard"
}

module "lb" {
  source = "./modules/networking/loadbalancer"
  rgname = "rg1"
  lbname = "lb1"
  location = "eastus"
  public_ip_id = module.pip.pip_id 
  sku = "Standard"
  backendpools = ["backendpool1","backendpool2"]

}