output "vnet_name_out" {
  value = azurerm_virtual_network.my_vnet.name
}

output "publicSub_name_out" {
  value = azurerm_subnet.public_subnet.name
}

output "privateSub_name_out" {
  value = azurerm_subnet.private_subnet.name
}

output "subnet_id"{
  value=azurerm_subnet.public_subnet.id
}
/*
output "network_interface_ids"{
  value=[azurerm_network_interface.myterraformnic.id]
}
*/

output "lb_ip"{
  value=azurerm_public_ip.loadBalancer_ip.ip_address
}

output "lbIp_id"{
  value=azurerm_public_ip.loadBalancer_ip.id
}

