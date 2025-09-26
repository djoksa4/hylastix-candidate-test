output "app_vm_private_ip" {
  value = module.vms.app_vm_private_ip
}

output "appgw_public_ip" {
  value = module.application_gateway.appgw_public_ip
}