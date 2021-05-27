resource "azurerm_network_interface" "vm-nic" {
  name                = "vm-nic"
  location            = data.azurerm_resource_group.prash-rg.location
  resource_group_name = data.azurerm_resource_group.prash-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "myvm" {
  name                = "testvm01"
  resource_group_name = data.azurerm_resource_group.prash-rg.name
  location            = data.azurerm_resource_group.prash-rg.location
  size                = "Standard_F2"
  admin_username      = "azureadmin"
  admin_password      = "Password@123"
  network_interface_ids = [
    azurerm_network_interface.prash-rg.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}