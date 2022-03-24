
# Create virtual machine
resource "azurerm_linux_virtual_machine" "appVm" {
  name                  = var.vm_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  network_interface_ids = var.network_interface_ids
  size                  = "Standard_DS1_v2"

    os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "myvm"
  admin_username                  = "azureuser"
  disable_password_authentication = false
  admin_password = "Password123"
  
}