# GENERAL
variable "project_name" {
  type        = string
  description = "Prefix for all resources in the project"

  validation {
    condition     = length(trimspace(var.project_name)) > 0
    error_message = "project_name variable must not be empty."
  }
}

variable "region" {
  type        = string
  description = "Azure region for resources"

  validation {
    condition     = length(trimspace(var.region)) > 0
    error_message = "region variable must not be empty."
  }
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
  sensitive = true

  validation {
    condition     = length(trimspace(var.subscription_id)) > 0
    error_message = "subscription_id variable must not be empty."
  }
}

# NETWORK
variable "address_space" {
  description = "VNet CIDR block"
  type        = list(string)

  validation {
    condition = length(var.address_space) > 0 && alltrue([for s in var.address_space : length(trimspace(s)) > 0])
    error_message = "address_space must be a non-empty list of non-empty strings."
  }
}

variable "subnets" {
  description = "List of subnets for the network module"
  type = list(object({
    name           = string
    address_prefix = string
  }))

  validation {
    condition = length(var.subnets) > 0 && alltrue([
                  for s in var.subnets : length(trimspace(s.name)) > 0 && length(trimspace(s.address_prefix)) > 0
                ])
    error_message = "subnets must be a non-empty list and each subnet must have a non-empty 'name' and 'address_prefix'."
  }
}

#VMs
variable "runner_vm_size" {
  description = "VM size"
  type        = string

  validation {
    condition     = length(trimspace(var.runner_vm_size)) > 0
    error_message = "runner_vm_size variable must not be empty."
  }
}

variable "runner_vm_admin_username" {
  description = "Admin username for the VM"
  type        = string
  sensitive   = true

  validation {
    condition     = length(trimspace(var.runner_vm_admin_username)) > 0
    error_message = "runner_vm_admin_username variable must not be empty."
  }
}

variable "runner_ssh_public_key" {
  description = "SSH public key for authentication"
  type        = string
  sensitive   = true

  validation {
    condition     = length(trimspace(var.runner_ssh_public_key)) > 0
    error_message = "runner_ssh_public_key variable must not be empty."
  }
}

variable "runner_registration_token" {
  description = "GitHub runner registration token"
  type        = string
  sensitive   = true

  validation {
    condition     = length(trimspace(var.runner_registration_token)) > 0
    error_message = "runner_registration_token variable must not be empty."
  }
}

variable "runner_github_url" {
  description = "GitHub repo/org URL for runner registration"
  type        = string

  validation {
    condition     = length(trimspace(var.runner_github_url)) > 0
    error_message = "runner_github_url variable must not be empty."
  }
}
