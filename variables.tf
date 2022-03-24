variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
}

variable "base_name" {
    type = string
    description = "The base of the name for the resource group and storage account"
    default="Vnet"
}

variable "location" {
    type = string
    description = "The location for the deplyment"
    default="East US"
}

variable "admin_user" {
   description = "User name to use as the admin account on the VMs that will be part of the VM scale set"
   default     = "azureuser"
}

variable "admin_password" {
   description = "Default password for admin account"
   default="Pass1234"
}