#getting this varaibles from another module
variable "resource_group_name" {
    type = string
    description = "Name of the resource group"
}

#getting by module
variable "network_id" {
  description = "the id of the network"
}

variable "location" {
    type = string
    description = "The location for the deployment"
}

#getting by module
variable "privateSubnet_id" {
  description = "the id of the private subnet"
}