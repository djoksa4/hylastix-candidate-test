output "app_vm_private_ip" {
  value = azurerm_linux_virtual_machine.app_vm.private_ip_address
}