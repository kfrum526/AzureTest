resource "azurerm_resource_group" "rg1" {
    name = "rg1"
    location = "EastUS"
}

resource "azurerm_network_security_group" "nsg1" {
    name = "NSG1"
    location = azurerm_resource_group.rg1.location
    resource_group_name = azurerm_resource_group.rg1.name
}

resource "azurerm_virtual_network" "Vnet1"{
    name = "VNet1"
    location = azurerm_resource_group.rg1.location
    resource_group_name = azurerm_resource_group.rg1.name
    address_space = ["10.0.0.0/16"]

    subnet  {
      address_prefix = "10.0.1.0/24"
      name = "Public"
    }

    subnet  {
      address_prefix = "10.0.2.0/24"
      name = "Private"
    }

    tags = {
      environment = "Testing"
    }
}