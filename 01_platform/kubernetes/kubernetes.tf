variable "resource_group_name" {}
variable "network_range" {}


output "k8s_host" { 
    value = module.aks.host
}
output "k8s_client_certificate" { 
    value = base64decode(module.aks.client_certificate)
}
output "k8s_client_key" { 
    value = base64decode(module.aks.client_key)
}
output "k8s_cluster_ca_certificate" { 
    value = base64decode(module.aks.cluster_ca_certificate)
}

# data "azuread_group" "aks_cluster_admins" {
#   name = "AKS-cluster-admins"
# }

module "aks" {
  source                           = "Azure/aks/azurerm"
  resource_group_name              = var.resource_group_name
#   client_id                        = "your-service-principal-client-appid"
#   client_secret                    = "your-service-principal-client-password"
#   kubernetes_version               = "1.19.3"
#   orchestrator_version             = "1.19.3"
  prefix                           = "aks"
  cluster_name                     = "data-platform"
#   vnet_subnet_id                   = "kubernetes_nodes" 
os_disk_size_gb                  = 50
#   sku_tier                         = "Paid" # defaults to Free
#   enable_role_based_access_control = true
#   rbac_aad_admin_group_object_ids  = [data.azuread_group.aks_cluster_admins.id]
#   rbac_aad_managed                 = true
#   private_cluster_enabled          = true # default value false
  enable_http_application_routing  = true
  enable_azure_policy              = true
  enable_auto_scaling              = true
  agents_min_count                 = 1
  agents_max_count                 = 6
  agents_count                     = null # Please set `agents_count` `null` while `enable_auto_scaling` is `true` to avoid possible `agents_count` changes.
#   agents_max_pods                  = 100
  agents_pool_name                 = "exnodepool"
  agents_availability_zones        = ["1", "2"]
  agents_type                      = "VirtualMachineScaleSets"

  agents_labels = {
    "nodepool" : "defaultnodepool"
  }

  agents_tags = {
    "Agent" : "defaultnodepoolagent"
  }

  network_plugin                 = "azure"
  network_policy                 = "azure"
  net_profile_dns_service_ip     = cidrhost("10.0.1.0/24", 2)
  net_profile_docker_bridge_cidr = "170.10.0.1/16"
  net_profile_service_cidr       = "10.0.1.0/24"

}