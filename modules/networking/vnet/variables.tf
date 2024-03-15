variable "rgname" {
  type    = string
  default = ""
}

variable "location" {
  type    = string
  default = ""
}

variable "vnetname" {
  type    = string
  default = ""
}

variable "vnet_addresspaces" {
  type = list(string)
  default = ""
}

variable "dns_servers" {
  type = list(string)
  default = ""
}
variable "subnets" {
  description = "Map of subnet names and their respective CIDR ranges"
  type = map
}