# Data Platform

## Key Technologies
- Azure
- Kubernetes
- Argo
- Databricks


## Installation flow

```
cd 01_platform
terraform init
terraform apply
```

Now copy the password for argo as described [in the docs](https://argo-cd.readthedocs.io/en/stable/getting_started/#4-login-using-the-cli)

```
kubectl -n argo-cd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

and forward the port to local

```
kubectl port-forward -n argo-cd svc/argo-argocd-server 8080:443
argocd login localhost:8080
```

