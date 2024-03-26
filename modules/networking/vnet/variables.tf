variable "rgname" {
  type    = string
}

variable "location" {
  type    = string
}

variable "vnetname" {
  type    = string
}

variable "vnet_addresspaces" {
  type = list(string)
}

variable "subnets" {
  type = list(object({
    name           = string
    address_prefix = string
  }))
  }