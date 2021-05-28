resource "azurerm_resource_group" "data_platform" {
  name     = "data_platform"
  location = "westeurope"
}
module "argo" {
  source = "./argo/"
}

module "network" {
  source              = "./network/"
  resource_group_name = azurerm_resource_group.data_platform.name
  address_space = "10.0.0.0/16"
  depends_on = [azurerm_resource_group.data_platform]
}
module "kubernetes" {
  depends_on = [module.network, azurerm_resource_group.data_platform]
  source              = "./kubernetes/"
  resource_group_name = azurerm_resource_group.data_platform.name
  network_range = module.network.address_space
}
