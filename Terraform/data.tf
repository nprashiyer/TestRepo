data "azurerm_resource_group" "prash-rg" {
  name = "1-b7c41511-playground-sandbox"
}

output "id" {
  value = data.azurerm_resource_group.prash-rg.id
}
