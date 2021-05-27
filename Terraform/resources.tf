resource "azurerm_storage_account" "my-st-ac" {
  name                     = "prastac897s6dfhbsj"
  resource_group_name      = data.azurerm_resource_group.prash-rg.name
  location                 = data.azurerm_resource_group.prash-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "test"
  }
}

#Virtual Network
resource "azurerm_virtual_network" "myvnet01" {
  name                = "vnetprod01"
  location            = data.azurerm_resource_group.prash-rg.location
  resource_group_name = data.azurerm_resource_group.prash-rg.name
  address_space       = ["10.0.0.0/16"]
  subnet {
    name           = "private"
    address_prefix = "10.0.11.0/24"
  }
  tags = {
    environment = "Production"
  }
}

#NSG

resource "azurerm_network_security_group" "mynsg" {
  name                = "Test-NSG"
  location            = data.azurerm_resource_group.prash-rg.location
  resource_group_name = data.azurerm_resource_group.prash-rg.name

  security_rule {
    name                       = "Allow_RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}

#Public SUbnet 
resource "azurerm_subnet" "public-subnet" {
  name                 = "public"
  resource_group_name  = data.azurerm_resource_group.prash-rg.name
  virtual_network_name = azurerm_virtual_network.myvnet01.name
  address_prefixes     = ["10.0.5.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "sbn-nsg-asso" {
  subnet_id                 = azurerm_subnet.public-subnet.id
  network_security_group_id = azurerm_network_security_group.mynsg.id
  depends_on                = [azurerm_subnet.public-subnet, azurerm_network_security_group.mynsg]
}