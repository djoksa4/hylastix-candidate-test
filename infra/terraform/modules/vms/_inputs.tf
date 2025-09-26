################ GENERAL ################
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

################ RUNNER VM ################
variable "runner_vm_subnet_id" {
  description = "Subnet ID where the runner VM will be deployed"
  type        = string
}

variable "runner_vm_size" {
  description = "VM size for the runner VM"
  type        = string
}

variable "runner_vm_admin_username" {
  description = "Admin username for the runner VM"
  type        = string
  sensitive   = true
}

variable "runner_vm_ssh_public_key" {
  description = "SSH public key for authentication"
  type        = string
  sensitive   = true
}

variable "runner_registration_token" {
  description = "GitHub runner registration token"
  type        = string
  sensitive   = true
}

variable "runner_github_url" {
  description = "GitHub repo/org URL for runner registration"
  type        = string
}

################ APP VM ################
variable "app_vm_subnet_id" {
  description = "Subnet ID where the app VM will be deployed"
  type        = string
}

variable "app_vm_size" {
  description = "VM size for the app VM"
  type        = string
}

variable "app_vm_admin_username" {
  description = "Admin username for the app VM"
  type        = string
  sensitive   = true
}

variable "app_vm_ssh_public_key" {
  description = "SSH public key for authentication"
  type        = string
  sensitive   = true
}