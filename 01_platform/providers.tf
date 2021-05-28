terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.61.0"
    }
  }
}

provider "kubernetes" {
  host                   = module.kubernetes.k8s_host
  client_certificate     = module.kubernetes.k8s_client_certificate
  client_key             = module.kubernetes.k8s_client_key
  cluster_ca_certificate = module.kubernetes.k8s_cluster_ca_certificate
}

provider "helm" {
  kubernetes {
    host                   = module.kubernetes.k8s_host
    client_certificate     = module.kubernetes.k8s_client_certificate
    client_key             = module.kubernetes.k8s_client_key
    cluster_ca_certificate = module.kubernetes.k8s_cluster_ca_certificate
  }
}

provider "azurerm" {
  features {}
}

