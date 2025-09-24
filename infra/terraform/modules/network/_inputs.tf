variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "region" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group to place networking resources in"
  type        = string
}

variable "address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}

variable "subnets" {
  description = "List of subnets to create inside the VNet"
  type = list(object({
    name           = string
    address_prefix = string
  }))
}


