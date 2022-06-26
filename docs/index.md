# Hack the Kubernetes with Vĩ

## Kubernetes Basics

If you don't know anything about Kubernetes this is a good start. Read it to learn about the architecture, components and basic actions in Kubernetes:

[:fontawesome-solid-book: Kubernetes Basics](content/en/docs/kubernetes/kubernetes-basics.md){ .md-button }

## Pentesting Kubernetes

### From the Outside

There are several possible Kubernetes services that you could find exposed on the Internet (or inside internal networks). If you find them you know there is Kubernetes environment in there.
Depending on the configuration and your privileges you might be able to abuse that environment, for more information:

[:fontawesome-solid-book: Pentesting Kubernetes Services](content/en/docs/kubernetes/pentesting-kubernetes-services.md){ .md-button }

### Enumeration inside a Pod

If you manage to compromise a Pod read the following page to learn how to enumerate and try to escalate privileges/escape:

[:fontawesome-solid-book: Attacking Kubernetes from inside a Pod](content/en/docs/kubernetes/attacking-kubernetes-from-inside-a-pod.md){ .md-button }

### Enumerating Kubernetes with Credentials

You might have managed to compromise user credentials, a user token or some service account token. You can use it to talk to the Kubernetes API service and try to enumerate it to learn more about it:

[:fontawesome-solid-book: Kubernetes Enumeration](content/en/docs/kubernetes/kubernetes-enumeration.md){ .md-button }

Another important details about enumeration and Kubernetes permissions abuse is the Kubernetes Role-Based Access Control (RBAC). If you want to abuse permissions, you first should read about it here:

[:fontawesome-solid-book: Kubernetes Role-Based Access Control (RBAC)](content/en/docs/kubernetes/kubernetes-role-based-access-control.md){ .md-button }

Knowing about RBAC and having enumerated the environment you can now try to abuse the permissions with:

[:fontawesome-solid-book: Abusing Roles/ClusterRoles in Kubernetes](content/en/docs/kubernetes/abusing-roles-clusterroles-in-kubernetes.md){ .md-button }

### Privesc to a different Namespace

If you have compromised a namespace you can potentially escape to other namespaces with more interesting permissions/resources:

[:fontawesome-solid-book: Kubernetes Namespace Escalation](content/en/docs/kubernetes/kubernetes-namespace-escalation.md){ .md-button }

### From Kubernetes to the Cloud

If you have compromised a K8s account or a pod, you might be able able to move to other clouds. This is because in clouds like AWS or GCP is possible to give a K8s SA permissions over the cloud.

[:fontawesome-solid-book: Kubernetes Access to other Clouds](content/en/docs/kubernetes/kubernetes-access-to-other-clouds.md){ .md-button }

### Kubernetes Hardening

[:fontawesome-solid-book: Kubernetes Hardening](content/en/docs/kubernetes/kubernetes-hardening.md){ .md-button }

### Kubernetes Network Attacks

[:fontawesome-solid-book: Kubernetes Network Attacks](content/en/docs/kubernetes/kubernetes-network-attacks.md){ .md-button }

## Labs to practice and learn

<https://securekubernetes.com/>

<https://madhuakula.com/kubernetes-goat/index.html>
