output "subnet_ids" {
  value = { for s in azurerm_subnet.this : s.name => s.id }
}