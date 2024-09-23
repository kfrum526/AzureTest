resource "azurerm_network_interface" "ni1" {
    name = "ani-network"
    location = azurerm_resource_group.rg1.location
    resource_group_name = azurerm_resource_group.rg1.name

    ip_configuration {
        name = "testconfiguration1"
        subnet_id = azurerm_subnet.public
        private_ip_address_allocatoin = "Dynamic"
    }
}

resource "azurerm_virtual_machine" "main" {
    name = "TestVM1"
    location = azurerm_resource_group.rg1.location
    resource_group_name = azurerm_resource_group.rg1.name
    network_interface_ids = [azurerm_network_interface.ni1.id]
    vm_size = "Standard_B2s"

    storage_image_reference {
        publisher = "Canonical"
        offer = "0001-com-ubuntu-server-jammy"
        sku = "22_04-lts"
        version = "latest"
    }
    storage_os_disk {
        name = "testdisk1"
        caching = "ReadWrite"
        create_option = "FromImage"
        managed_disk_id = "Standard_LRS"
    }
    os_profile {
        computer_name = "hostname"
        admin_username = "xadmin"
        admin_password = "!QAZ@WSX3edc4rfv"
    }
    os_profile_linux_config {
        disable_password_authentication = false
    }
}