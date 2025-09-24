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

variable "subnet_id" {
  description = "Subnet ID where the VM will be deployed"
  type        = string
}

variable "runner_vm_size" {
  description = "VM size"
  type        = string
}

variable "runner_vm_admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "runner_ssh_public_key" {
  description = "SSH public key for authentication"
  type        = string
}

variable "runner_registration_token" {
  description = "GitHub runner registration token"
  type        = string
}

variable "runner_github_url" {
  description = "GitHub repo/org URL for runner registration"
  type        = string
}