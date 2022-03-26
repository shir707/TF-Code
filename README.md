## General Info
*In this project, I implemented terraform code in order to create azure resources.<br />
*This project implemented by using modules, and one root module that is using that modules.<br />
*I created vnet with two subnets: "public" and "private". Each subnet has his own NSG role.<br />
*I created a load balancer with scale set by terraform code.<br />
*The bootcamp application is installed on that machines (github link for the application: https://github.com/shir707/bootcamp-app)<br />
*I created managed flexible postgres-dd in order to save the progress for each user.<br />
*And created storage account in order to store the Terraform state.<br />

## Requirements for terraform code

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 2.65 |

## Setup
1.clone or download source files<br />
2.run on the terminal: "terraform init"<br />
3.run on the terminal: "terraform plan -out plan.out"<br />
4.run on the terminal: "terraform apply plan.out"<br />

## In order to connect to the website application
write in your browser http://20.127.181.133:8080/

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.99.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_LoadBalancer"></a> [LoadBalancer](#module\_LoadBalancer) | ./modules/loadBalancer | n/a |
| <a name="module_PostgresDb"></a> [PostgresDb](#module\_PostgresDb) | ./modules/postgressSql | n/a |
| <a name="module_ResourceGroup"></a> [ResourceGroup](#module\_ResourceGroup) | ./modules/resourceGroup | n/a |
| <a name="module_VirtualNetwork"></a> [VirtualNetwork](#module\_VirtualNetwork) | ./modules/network | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine_scale_set.vmss](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_monitor_autoscale_setting.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_storage_account.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.tfstate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [random_string.resource_code](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | password for admin account | `string` | n/a | yes |
| <a name="input_admin_user"></a> [admin\_user](#input\_admin\_user) | User name to use as the admin account on the VMs that will be part of the VM scale set | `string` | `"azureuser"` | no |
| <a name="input_administrator_password"></a> [administrator\_password](#input\_administrator\_password) | password for admin postgress account | `string` | n/a | yes |
| <a name="input_base_name"></a> [base\_name](#input\_base\_name) | The base of the name for the resource group and storage account | `string` | `"Bootcamp"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location for the deplyment | `string` | `"East US"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix which should be used for all resources in this example | `string` | `"week5"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_RgName"></a> [RgName](#output\_RgName) | n/a |
| <a name="output_container_name"></a> [container\_name](#output\_container\_name) | n/a |
| <a name="output_lb_ip"></a> [lb\_ip](#output\_lb\_ip) | n/a |
| <a name="output_storage_name"></a> [storage\_name](#output\_storage\_name) | n/a |
