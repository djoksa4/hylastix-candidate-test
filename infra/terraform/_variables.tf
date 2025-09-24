variable "project_name" {
  type        = string
  description = "Prefix for all resources in the project"
}

variable "region" {
  type        = string
  description = "Azure region for resources"
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
  sensitive = true
}

variable "address_space" {
  description = "VNet CIDR block"
  type        = list(string)
}

variable "subnets" {
  description = "List of subnets for the network module"
  type = list(object({
    name           = string
    address_prefix = string
  }))
}
