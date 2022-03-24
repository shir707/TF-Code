#getting this varaibles from another module
variable "resource_group_name" {
    type = string
    description = "Name of the resource group"
}

variable "location" {
    type = string
    description = "The location for the deployment"
}

variable "vnet_name" {
    type = string
    description = "The name of the vnet"
    default="myVnet"
}

variable "public_sub_name"{
    type = string
    description = "The name of the vnet"
    default="publicSubnet"
}

variable "private_sub_name"{
    type = string
    description = "The name of the vnet"
    default="privateSubnet"
}
