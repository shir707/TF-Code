output "RgName" {
  value = module.ResourceGroup.rg_name_out
}


output "lb_ip"{
  value=module.VirtualNetwork.lb_ip
}

output "storage_name"{
  value=azurerm_storage_account.storage.name
}

output "container_name"{
  value=azurerm_storage_container.tfstate.name
}

output "Password" {
  value = var.admin_password
}