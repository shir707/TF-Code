variable "vm_name" {
    type = string
    description = "The name of the vnet"
    default="appVm"
}

variable "resource_group_name" {
    type = string
    description = "Name of the resource group"
}

variable "location" {
    type = string
    description = "The location for the deployment"
}

variable network_interface_ids{
    type=list
    description="the id of the network interface"
}