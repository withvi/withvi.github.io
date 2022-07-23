---
hide:
  - tags
tags:
  - ArgoCD
---

# ArgoCD

## Install ArgoCD with Autopilot

### Git Authentication

```sh
export GIT_TOKEN=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
```

### Export Clone URL

```sh
export GIT_REPO=https://github.com/nhamchanvi/bic-gitops
```

### Set up the GitOps Repository

```sh
argocd-autopilot repo bootstrap
```

The output is similar to this:

```sh
INFO cloning repo: https://github.com/nhamchanvi/bic-gitops.git 
WARNING --provider not specified, assuming provider from url: github 
INFO empty repository, initializing a new one with specified remote 
INFO using revision: "", installation path: ""    
INFO using context: "do-k8s-sbx-istio", namespace: "argocd" 
INFO applying bootstrap manifests to cluster...   
namespace/argocd created
customresourcedefinition.apiextensions.k8s.io/applications.argoproj.io unchanged
customresourcedefinition.apiextensions.k8s.io/applicationsets.argoproj.io unchanged
customresourcedefinition.apiextensions.k8s.io/appprojects.argoproj.io unchanged
serviceaccount/argocd-application-controller created
serviceaccount/argocd-applicationset-controller created
serviceaccount/argocd-dex-server created
serviceaccount/argocd-notifications-controller created
serviceaccount/argocd-redis created
serviceaccount/argocd-repo-server created
serviceaccount/argocd-server created
role.rbac.authorization.k8s.io/argocd-application-controller created
role.rbac.authorization.k8s.io/argocd-applicationset-controller created
role.rbac.authorization.k8s.io/argocd-dex-server created
role.rbac.authorization.k8s.io/argocd-notifications-controller created
role.rbac.authorization.k8s.io/argocd-server created
clusterrole.rbac.authorization.k8s.io/argocd-application-controller unchanged
clusterrole.rbac.authorization.k8s.io/argocd-server unchanged
rolebinding.rbac.authorization.k8s.io/argocd-application-controller created
rolebinding.rbac.authorization.k8s.io/argocd-applicationset-controller created
rolebinding.rbac.authorization.k8s.io/argocd-dex-server created
rolebinding.rbac.authorization.k8s.io/argocd-notifications-controller created
rolebinding.rbac.authorization.k8s.io/argocd-redis created
rolebinding.rbac.authorization.k8s.io/argocd-server created
clusterrolebinding.rbac.authorization.k8s.io/argocd-application-controller unchanged
clusterrolebinding.rbac.authorization.k8s.io/argocd-server unchanged
configmap/argocd-cm created
configmap/argocd-cmd-params-cm created
configmap/argocd-gpg-keys-cm created
configmap/argocd-notifications-cm created
configmap/argocd-rbac-cm created
configmap/argocd-ssh-known-hosts-cm created
configmap/argocd-tls-certs-cm created
secret/argocd-notifications-secret created
secret/argocd-secret created
service/argocd-applicationset-controller created
service/argocd-dex-server created
service/argocd-metrics created
service/argocd-notifications-controller-metrics created
service/argocd-redis created
service/argocd-repo-server created
service/argocd-server created
service/argocd-server-metrics created
deployment.apps/argocd-applicationset-controller created
deployment.apps/argocd-dex-server created
deployment.apps/argocd-notifications-controller created
deployment.apps/argocd-redis created
deployment.apps/argocd-repo-server created
deployment.apps/argocd-server created
statefulset.apps/argocd-application-controller created
networkpolicy.networking.k8s.io/argocd-application-controller-network-policy created
networkpolicy.networking.k8s.io/argocd-dex-server-network-policy created
networkpolicy.networking.k8s.io/argocd-redis-network-policy created
networkpolicy.networking.k8s.io/argocd-repo-server-network-policy created
networkpolicy.networking.k8s.io/argocd-server-network-policy created
secret/autopilot-secret created

INFO pushing bootstrap manifests to repo          
Resolving deltas: 100% (1/1), done.
INFO applying argo-cd bootstrap application       
application.argoproj.io/autopilot-bootstrap created
INFO running argocd login to initialize argocd config 
'admin:login' logged in successfully
Context 'autopilot' updated

INFO argocd initialized. password: uoRzYtW3RB-sPsVc 
INFO run:

    kubectl port-forward -n argocd svc/argocd-server 8080:80
```

