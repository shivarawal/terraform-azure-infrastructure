output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "virtual_network_name" {
  value = module.network.vnet_name
}

output "subnet_name" {
  value = module.network.subnet_name
}

output "public_ip_address" {
  value = azurerm_public_ip.main[*].ip_address
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.main.name
}

