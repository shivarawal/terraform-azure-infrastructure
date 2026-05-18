terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.73.0"
    }
  }
}

provider "azurerm" {
  subscription_id = ""
  client_id       = ""
  client_secret   = ""
  tenant_id       = ""
  features {
  }
}
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = local.common_tags
}



resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = module.network.subnet_id
  network_security_group_id = azurerm_network_security_group.main["frontend"].id

  depends_on = [
    module.network,
    azurerm_network_security_group.main
  ]
}

resource "azurerm_network_security_group" "main" {

  for_each = {
    frontend = "frontend-nsg"
    backend  = "backend-nsg"
  }

  name                = each.value
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = local.common_tags
}

resource "azurerm_public_ip" "main" {
  count               = 2
  name                = "${local.prefix}-publicip-${count.index}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"

  tags = local.common_tags
}

resource "azurerm_network_interface" "main" {
  lifecycle {
    create_before_destroy = true
  }

  name                = "${local.prefix}-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = local.common_tags

  depends_on = [module.network, azurerm_public_ip.main]

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.network.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main[0].id
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = "${local.prefix}-machine"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = var.vm_size
  admin_username      = var.admin_username

  tags = local.common_tags

  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("C:/Users/shiva/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       =  "server"
    version   = "latest"
  }
}
module "network" {
  source = "./modules/network"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
}