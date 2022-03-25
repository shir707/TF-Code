output "RgName" {
  value = module.ResourceGroup.rg_name_out
}


output "lb_ip"{
  value=module.VirtualNetwork.lb_ip
}

output "vmss_ip"{
  value=module.VirtualNetwork.vmss_ip
}