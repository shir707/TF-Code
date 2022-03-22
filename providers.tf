# Configure the Azure provider
#the source attribute defines an optional hostname, a namespace, and the provider type.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 1.1.0"
}
# A provider is a plugin that Terraform uses to create and manage your resources
#The provider block configures the specified provider
provider "azurerm" {
  features {}
}
