# Create virtual network
resource "azurerm_virtual_network" "my_vnet" {
  name                = var.vnet_name
  address_space       = ["10.0.0.0/16"]
  resource_group_name      = var.resource_group_name
  location                 = var.location
}

# Create Public subnet
resource "azurerm_subnet" "public_subnet" {
  name                 = var.public_sub_name
  resource_group_name      = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.0.0/24"]
  depends_on = [
    azurerm_virtual_network.my_vnet
  ]
}

# Create Private subnet
resource "azurerm_subnet" "private_subnet" {
  name                 = var.private_sub_name
  resource_group_name      = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
  depends_on = [
    azurerm_virtual_network.my_vnet
  ]
}


 resource "azurerm_public_ip" "loadBalancer_ip" {
  name                         = "publicIPForLB"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  allocation_method            = "Static"
  sku="Standard"
  depends_on=[var.resource_group_name]
 }

 resource "azurerm_public_ip_prefix" "vmss_ip" {
  name                = "${var.prefix}-pip"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  prefix_length = 30
  depends_on=[var.resource_group_name]
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "app_nsg" {
  name                = "app-nsg"
   resource_group_name      = var.resource_group_name
  location                 = var.location

  security_rule {
    name                       = "SSH_allow"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "79.179.190.47"
    destination_address_prefix = "*"
  }
   security_rule {
    name                       = "SSH_deny"
    priority                   = 310
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
   security_rule {
    name                       = "Port_8080"
    priority                   = 320
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "db_nsg" {
  name                = "db-nsg"
   resource_group_name      = var.resource_group_name
  location                 = var.location

  security_rule {
    name                       = "postgres_allow"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = "10.0.0.5"
    destination_address_prefix = "*"
  }
   security_rule {
    name                       = "postgres_allow2"
    priority                   = 310
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = "10.0.0.7"
    destination_address_prefix = "*"
  }
   security_rule {
    name                       = "postgres_deny"
    priority                   = 320
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

#connect app subnet to app_nsg
resource "azurerm_subnet_network_security_group_association" "appNsg_association" {
  subnet_id                 = azurerm_subnet.public_subnet.id
  network_security_group_id = azurerm_network_security_group.app_nsg.id
  depends_on = [
    azurerm_network_security_group.app_nsg
  ]
}

#connect db subnet to db_nsg
resource "azurerm_subnet_network_security_group_association" "dbNsg_association" {
  subnet_id                 = azurerm_subnet.private_subnet.id
  network_security_group_id = azurerm_network_security_group.db_nsg.id
  depends_on = [
    azurerm_network_security_group.db_nsg
  ]
}
/*
# Create network interface
resource "azurerm_network_interface" "myterraformnic" {
  name                = "myNIC"
   resource_group_name      = var.resource_group_name
  location                 = var.location

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = azurerm_subnet.public_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.loadBalancer_ip.id
  }
  depends_on = [
    azurerm_virtual_network.my_vnet
  ]
  
}


# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.myterraformnic.id
  network_security_group_id = azurerm_network_security_group.loadBalancer_nsg.id
}
*/
