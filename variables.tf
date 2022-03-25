variable "prefix" {
  type=string
  description = "The prefix which should be used for all resources in this example"
  default="week5"
}

variable "base_name" {
    type = string
    description = "The base of the name for the resource group and storage account"
    default="Bootcamp"
}

variable "location" {
    type = string
    description = "The location for the deplyment"
    default="East US"
}

variable "admin_user" {
  type = string
   description = "User name to use as the admin account on the VMs that will be part of the VM scale set"
   default     = "azureuser"
}

variable "admin_password" {
  type = string
   description = "password for admin account"
   sensitive=true 
 }

 variable "administrator_password" {
  type = string
   description = "password for admin postgress account"
   sensitive=true 
 }