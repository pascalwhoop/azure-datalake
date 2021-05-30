# Installation flow

![](img/bootstrap.drawio.svg)

```
cd 01_platform
terraform init
terraform apply
```

Now copy the password for argo as described [in the docs](https://argo-cd.readthedocs.io/en/stable/getting_started/#4-login-using-the-cli)

```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

and forward the port to local

```
kubectl port-forward -n argocd svc/argo-argocd-server 8080:443
argocd login localhost:8080
```

Next install the ["app of apps" pattern](https://argoproj.github.io/argo-cd/operator-manual/cluster-bootstrapping/)


```bash
cd 02_kubernetes/argo-spec
kubectl apply -f application.yaml
```