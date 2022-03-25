module "ResourceGroup" {
  source = "./modules/resourceGroup"
  base_name = var.base_name
  location = var.location
}

module "VirtualNetwork"{
  source="./modules/network"
  resource_group_name = module.ResourceGroup.rg_name_out
  location=var.location
  prefix=var.prefix
}

module PostgresDb{
  source="./modules/postgressSql"
  resource_group_name = module.ResourceGroup.rg_name_out
  location=var.location
  virtual_network_id =module.VirtualNetwork.virtual_network_id
  delegated_subnet_id=module.VirtualNetwork.delegated_subnet_id 
  administrator_password=var.administrator_password
}

/*
module "AppServer"{
  source="./modules/appServer"
  resource_group_name = module.ResourceGroup.rg_name_out
  location=var.location
  network_interface_ids=module.VirtualNetwork.network_interface_ids
}
*/


module "LoadBalancer"{
  source="./modules/loadBalancer"
  resource_group_name = module.ResourceGroup.rg_name_out
  location=var.location
  lbIp_id=module.VirtualNetwork.lbIp_id
}



resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                            = "${var.prefix}-vmss"
  resource_group_name = module.ResourceGroup.rg_name_out
  location=var.location
  sku                             = "Standard_B2s"
  instances                       = 2
  admin_username                  = var.admin_user
  admin_password                  = var.admin_password
  disable_password_authentication = false

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = module.VirtualNetwork.subnet_id
      load_balancer_backend_address_pool_ids =[module.LoadBalancer.backendPool_id]

      public_ip_address {
        name                = "first"
        public_ip_prefix_id = module.VirtualNetwork.vmss_ip
      }
    }
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  # Since these can change via auto-scaling outside of Terraform,
  # let's ignore any changes to the number of instances
  lifecycle {
    ignore_changes = ["instances"]
  }
   depends_on=[
      module.VirtualNetwork.vnet_name_out
    ]
}

resource "azurerm_monitor_autoscale_setting" "main" {
  name                = "autoscale-config"
  resource_group_name = module.ResourceGroup.rg_name_out
  location=var.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.vmss.id

  profile {
    name = "AutoScale"

    capacity {
      default = 2
      minimum = 2
      maximum = 5
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }
}

