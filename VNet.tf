resource "azurerm_resource_group" "rg1" {
    name = "TestRG1"
    location = "EastUS"
}

resource "azurerm_network_security_group" "nsg1" {
    name = "TestNSG1"
    location = azurerm_resource_group.rg1.location
    resource_group_name = azurerm_resource_group.rg1.name
}

resource "azurerm_virtual_network" "Vnet1"{
    name = "TestVN"
    location = azurerm_resource_group.rg1.location
    resource_group_name = azurerm_resource_group.rg1.name
    address_space = ["11.0.0.0/16"]

    tags = {
      environment = "Testing"
    }
}

resource "azurerm_subnet" "public"{
  name = "Public"
  resource_group_name = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.Vnet1.name
  address_prefixes = ["11.0.0.0/24"]
}

resource "azurerm_subnet" "private" {
  name = "Private"
  resource_group_name = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.Vnet1.name
  address_prefixes = ["11.0.1.0/24"]
}