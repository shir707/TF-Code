// Here we are creating the Azure Load Balancer
// This will be sitting in front of the Load Balancer

resource "azurerm_lb" "app_balancer" {
  name                = "app-balancer"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku="Standard"
  sku_tier = "Regional"
  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = var.lbIp_id
  }
  depends_on=[
    var.lbIp_id
  ]

}

// Here we are defining the backend pool
resource "azurerm_lb_backend_address_pool" "scalesetpool" {
  loadbalancer_id = azurerm_lb.app_balancer.id
  name            = "scalesetpool"
  depends_on=[
    azurerm_lb.app_balancer
  ]
}

// Here we are defining the Health Probe
resource "azurerm_lb_probe" "ProbeA" {
  resource_group_name      = var.resource_group_name
  loadbalancer_id     = azurerm_lb.app_balancer.id
  name                = "probeA"
  port                = var.application_port
  protocol            =  "Tcp"
  depends_on=[
    azurerm_lb.app_balancer
  ]
}

// Here we are defining the Load Balancing Rule
resource "azurerm_lb_rule" "RuleA" {
  resource_group_name      = var.resource_group_name
  loadbalancer_id                = azurerm_lb.app_balancer.id
  name                           = "RuleA"
  protocol                       = "Tcp"
  frontend_port                  = var.application_port
  backend_port                   = var.application_port
  frontend_ip_configuration_name = "frontend-ip"
  backend_address_pool_ids = [ azurerm_lb_backend_address_pool.scalesetpool.id ]
}