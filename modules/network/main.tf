resource "azurerm_virtual_network" "main" {
  name                = "main-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = {
  environment = "dev"
  owner       = "shiva"
  project     = "terraform-learning"
}

}

resource "azurerm_subnet" "main" {

  depends_on = [
    azurerm_virtual_network.main
  ]

  name                 = "internal"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}