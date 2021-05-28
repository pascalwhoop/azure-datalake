variable "resource_group_name" {}
variable "address_space"{
    default = "10.0.0.0/16"
}
# locals {
    # cidr_ranges = cidrsubnets(var.address_space, 4, 4, 4)
# }
output "address_space" {
    value = var.address_space
}
# output "subnet_cidr_ranges"{
    # 
    # value = zipmap(
        # module.network.vnet_subnets,
        # slice(local.cidr_ranges, 0, 2)
        # 
    # )
    # 
# }

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  vnet_name = "data-platform"
#   subnet_prefixes     = slice(local.cidr_ranges, 0, 2)
#   subnet_names        = ["kubernetes_nodes", "kubernetes_services"]
}
