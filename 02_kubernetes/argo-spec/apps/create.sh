#!/bin/bash
argocd app create apps \
    --dest-namespace argo-cd \
    --dest-server https://kubernetes.default.svc \
    --repo https://github.com/pascalwhoop/azure-datalake \
    --path 02_kubernetes/apps  
argocd app sync apps  