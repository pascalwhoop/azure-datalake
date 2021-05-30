resource "kubernetes_namespace" "argo" {
  metadata {
    annotations = {
      name = "argocd"
    }

    name = "argocd"
  }
}

resource "helm_release" "argo" {
    name = "argo"
    repository = "https://argoproj.github.io/argo-helm"
    chart = "argocd"
    namespace = kubernetes_namespace.argo.metadata[0].name

    # pass through ssl to enable grpc/https for argocd CLI, see
    # https://argoproj.github.io/argo-cd/operator-manual/ingress/#kubernetesingress-nginx
    set {
        name = "server.ingress.annotations"
        value = {
            "kubernetes.io/ingress.class": "nginx",
            "nginx.ingress.kubernetes.io/force-ssl-redirect": "true",
            "nginx.ingress.kubernetes.io/ssl-passthrough": "true",
        }
    }
  
}