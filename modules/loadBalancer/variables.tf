variable "resource_group_name" {
    type = string
    description = "Name of the resource group"
}

variable "location" {
    type = string
    description = "The location for the deployment"
}

variable "lbIp_id"{
    description="the id of the public ip(send by network)"
}

variable "application_port" {
   description = "Port that you want to expose to the external load balancer"
   default     = 8080
}