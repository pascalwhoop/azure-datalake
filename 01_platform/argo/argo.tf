resource "kubernetes_namespace" "argo" {
  metadata {
    annotations = {
      name = "argo-cd"
    }

    name = "argo-cd"
  }
}

resource "helm_release" "argo" {
    name = "argo"
    repository = "https://argoproj.github.io/argo-helm"
    chart = "argo-cd"
    namespace = kubernetes_namespace.argo.metadata[0].name
  
}