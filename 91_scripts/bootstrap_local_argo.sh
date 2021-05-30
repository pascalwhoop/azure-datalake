#!/bin/bash

# bootstraps local argo with minikube
cd (git rev-parse --show-toplevel)

minikube start --cpus=4 --memory=8192Mb --driver=kvm2 --addons dashboard,ingress,metrics-server
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch deployment \
  ingress-nginx-controller \
  --namespace ingress-nginx \
  --type='json' \
  -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--enable-ssl-passthrough"}]'