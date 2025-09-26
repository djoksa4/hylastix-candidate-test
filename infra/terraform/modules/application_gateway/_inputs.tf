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

variable "app_vm_private_ip" {
  description = "Private IP of the app VM"
  type        = string
}

variable "appgw_subnet_id" {
  description = "Subnet ID where the app GW will be deployed"
  type        = string
}