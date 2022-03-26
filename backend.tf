terraform {

 backend "azurerm" {
        resource_group_name  = "BootcampRG"
        storage_account_name = "tfstatelmtyu"
        container_name       = "tfstate"
        key                  = "bootcamp.terraform.tfstate"
    }

}