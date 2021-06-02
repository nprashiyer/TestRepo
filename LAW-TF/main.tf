terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 2.49.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "logs" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

resource "random_id" "logs" {
  keepers = {
    # Generate a new id each time we switch to a new resource group
    group_name = azurerm_resource_group.logs.name
  }

  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "logs" {
  name                = var.name
  location            = azurerm_resource_group.logs.location
  resource_group_name = azurerm_resource_group.logs.name
  sku                 = var.sku
  

  tags = var.tags
}

