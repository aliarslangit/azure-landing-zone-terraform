variable "lbname" {
  type    = string
  default = ""

}
variable "rgname" {
  type    = string
  default = ""

}
variable "location" {
  type    = string
  default = ""
}

variable "sku" {
  type    = string
  default = ""
}

variable "public_ip_id" {
  type    = string
  default = ""
}
variable "backendpools" {
  type = list(string)
  default = [
    "backendpool1", "backendpool2"
  ]
}
variable "lbrules" {
  type = list(any)
  default = [
    {
      backendport  = "3389"
      frontendport = "3389"
    },
    {
      backendport  = "80"
      frontendport = "80"
    }
  ]
}