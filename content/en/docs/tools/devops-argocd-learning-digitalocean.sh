#!/bin/bash
# Install ArgoCD on DigitalOcean
# ------------------------------------------------
# Author: Nhâm Chấn Vĩ - nhamchanvi@gmail.com -13 July 2022

##
# Install Argo CD with full features
##
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# ##
# # Install Argo CD core without UI, SSO, multi-cluster features
# ##
# kubectl create namespace argocd
# kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/core-install.yaml

##
# Download Argo CD CLI
##
brew install argocd

# ##
# # Access the Argo CD API server through Load Balancer
# ##
# kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

##
# Access the Argo CD API server through Port-forwarding
##
kubectl port-forward svc/argocd-server -n argocd 8080:443

##
# Get the default admin user password
##
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

##
# Login to Argo CD CLI with admin and the inital password above
##
argocd login localhost:8080

##
# Change the password
##
argocd account update-password

# ##
# # Add the target cluster to deploy (optional)
# ##
# argocd cluster add do-k8s-sbx-istio

##
# 
##
argocd app create helm-guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path helm-guestbook --dest-server https://kubernetes.default.svc --dest-namespace default

argocd app create productpage --repo git@bitbucket.org:nhamchanvi/dso.git --revision gitops-demo --path productpage --dest-server https://kubernetes.default.svc --dest-namespace default
argocd app create reviews --repo git@bitbucket.org:nhamchanvi/dso.git --revision gitops-demo --path reviews --dest-server https://kubernetes.default.svc --dest-namespace default
argocd app create ratings --repo git@bitbucket.org:nhamchanvi/dso.git --revision gitops-demo --path ratings --dest-server https://kubernetes.default.svc --dest-namespace default
argocd app create details --repo git@bitbucket.org:nhamchanvi/dso.git --revision gitops-demo --path details --dest-server https://kubernetes.default.svc --dest-namespace default


##
# List ArgoCD application
##
argocd app list

##
# Get detail of the application
##
argocd app get helm-guestbook

##
# Sync the application to ArgoCD
##
argocd app sync helm-guestbook

##
# 
##


##
# 
##
