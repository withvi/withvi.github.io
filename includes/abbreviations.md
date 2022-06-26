<!-- *[Add-ons]: Resources that extend the functionality of Kubernetes.
*[Admission Controller]: A piece of code that intercepts requests to the Kubernetes API server prior to persistence of the object.
*[Affinity]: In Kubernetes, affinity is a set of rules that give hints to the scheduler about where to place pods.
*[Aggregation Layer]: The aggregation layer lets you install additional Kubernetes-style APIs in your cluster.
*[Annotation]: A key-value pair that is used to attach arbitrary non-identifying metadata to objects.
*[API Group]: A set of related paths in Kubernetes API.
*[API Server]: Also known as:kube-apiserver. The API server is a component of the Kubernetes control plane that exposes the Kubernetes API. The API server is the front end for the Kubernetes control plane.
*[API-initiated eviction]: API-initiated eviction is the process by which you use the Eviction API to create an Eviction object that triggers graceful pod termination.
*[App Container]: Application containers (or app containers) are the containers in a pod that are started after any init containers have completed.
*[Application Architect]: A person responsible for the high-level design of an application.
*[Application Developer]: A person who writes an application that runs in a Kubernetes cluster.
*[Applications]: The layer where various containerized applications run.
*[Approver]: A person who can review and approve Kubernetes code contributions.
*[cAdvisor]: cAdvisor (Container Advisor) provides container users an understanding of the resource usage and performance characteristics of their running containers.
*[Certificate]: A cryptographically secure file used to validate access to the Kubernetes cluster.
*[cgroup]: A group (control group) of Linux processes with optional resource isolation, accounting and limits.
*[CIDR]: CIDR (Classless Inter-Domain Routing) is a notation for describing blocks of IP addresses and is used heavily in various networking configurations.
*[CLA]: (Contributor License Agreement) Terms under which a contributor grants a license to an open source project for their contributions.
*[Cloud Controller Manager]: A Kubernetes control plane component that embeds cloud-specific control logic. The cloud controller manager lets you link your cluster into your cloud provider's API, and separates out the components that interact with that cloud platform from components that only interact with your cluster.
*[Cloud Native Computing Foundation]: The Cloud Native Computing Foundation (CNCF) builds sustainable ecosystems and fosters a community around projects that orchestrate containers as part of a microservices architecture. Kubernetes is a CNCF project.
*[Cloud Provider]: Also known as:Cloud Service Provider. A business or other organization that offers a cloud computing platform.
*[Cluster Architect]: A person who designs infrastructure that involves one or more Kubernetes clusters.
*[Cluster Infrastructure]: The infrastructure layer provides and maintains VMs, networking, security groups and others.
*[Cluster Operations]: The work involved in managing a Kubernetes cluster: managing day-to-day operations, and co-ordinating upgrades.
*[Cluster Operator]: A person who configures, controls, and monitors clusters.
*[Cluster]: A set of worker machines, called nodes, that run containerized applications. Every cluster has at least one worker node.
*[Code Contributor]: A person who develops and contributes code to the Kubernetes open source codebase.
*[ConfigMap]: An API object used to store non-confidential data in key-value pairs. Pods can consume ConfigMaps as environment variables, command-line arguments, or as configuration files in a volume.
*[Container Environment Variables]: Container environment variables are name=value pairs that provide useful information into containers running in a pod
*[Container Lifecycle Hooks]: The lifecycle hooks expose events in the Container management lifecycle and let the user run code when the events occur.
*[Container Network Interface]: Container network interface (CNI) plugins are a type of Network plugin that adheres to the appc/CNI specification.
*[Container Runtime]: The container runtime is the software that is responsible for running containers.
*[Container Runtime Interface]: The container runtime interface (CRI) is an API for container runtimes to integrate with kubelet on a node.
*[Container Storage Interface]: The Container Storage Interface (CSI) defines a standard interface to expose storage systems to containers.
*[Ephemeral Container]: A Container type that you can temporarily run inside a Pod.
*[Init Container]: One or more initialization containers that must run to completion before any app containers run.
*[Container]: A lightweight and portable executable image that contains software and all of its dependencies.
*[containerd]: A container runtime with an emphasis on simplicity, robustness and portability
*[Contributor]: Someone who donates code, documentation, or their time to help the Kubernetes project or community.
*[Control Plane]: The container orchestration layer that exposes the API and interfaces to define, deploy, and manage the lifecycle of containers.
*[Controller]: In Kubernetes, controllers are control loops that watch the state of your cluster, then make or request changes where needed. Each controller tries to move the current cluster state closer to the desired state.
*[CRI-OA]: tool that lets you use OCI container runtimes with Kubernetes CRI.
*[CronJob]: Manages a Job that runs on a periodic schedule.
*[CustomResourceDefinition]: Custom code that defines a resource to add to your Kubernetes API server without building a complete custom server.
*[DaemonSet]: Ensures a copy of a Pod is running across a set of nodes in a cluster.
*[Data Plane]: The layer that provides capacity such as CPU, memory, network, and storage so that the containers can run and connect to a network.
*[Deployment]: An API object that manages a replicated application, typically by running Pods with no local state.
*[Developer]: (disambiguation) May refer to: Application Developer, Code Contributor, or Platform Developer.
*[Device Plugin]: Device plugins run on worker Nodes and provide Pods with access to resources, such as local hardware, that require vendor-specific initialization or setup steps.
*[Disruption]: Disruptions are events that lead to one or more Pods going out of service. A disruption has consequences for workload resources, such as Deployment, that rely on the affected Pods.
*[Docker]: Docker (specifically, Docker Engine) is a software technology providing operating-system-level virtualization also known as containers.
*[Dockershim]: The dockershim is a component of Kubernetes version 1.23 and earlier. It allows the kubelet to communicate with Docker Engine.
*[Horizontal Pod Autoscaler]: Also known as:HPA. An API resource that automatically scales the number of Pod replicas based on targeted CPU utilization or custom metric targets.
*[Downstream]: (disambiguation) May refer to: code in the Kubernetes ecosystem that depends upon the core Kubernetes codebase or a forked repo.
*[Dynamic Volume Provisioning]: Allows users to request automatic creation of storage Volumes.
*[Endpoints]: Endpoints track the IP addresses of Pods with matching selectors.
*[EndpointSlice]: A way to group network endpoints together with Kubernetes resources.
*[etcd]: Consistent and highly-available key value store used as Kubernetes' backing store for all cluster data.
*[Event]: Each Event is a report of an event somewhere in the cluster. It generally denotes some state change in the system.
*[Eviction]: Eviction is the process of terminating one or more Pods on Nodes.
*[Extensions]: Extensions are software components that extend and deeply integrate with Kubernetes to support new types of hardware.
*[Finalizer]: Finalizers are namespaced keys that tell Kubernetes to wait until specific conditions are met before it fully deletes resources marked for deletion. Finalizers alert controllers to clean up resources the deleted object owned.
*[FlexVolume]: FlexVolume is a deprecated interface for creating out-of-tree volume plugins. The Container Storage Interface is a newer interface that addresses several problems with FlexVolume.
*[Garbage Collection]: Garbage collection is a collective term for the various mechanisms Kubernetes uses to clean up cluster resources.
*[Helm Chart]: A package of pre-configured Kubernetes resources that can be managed with the Helm tool.
*[HostAliases]: A HostAliases is a mapping between the IP address and hostname to be injected into a Pod's hosts file.
*[Image]: Stored instance of a Container that holds a set of software needed to run an application.
*[Ingress]: An API object that manages external access to the services in a cluster, typically HTTP.
*[Istio]: An open platform (not Kubernetes-specific) that provides a uniform way to integrate microservices, manage traffic flow, enforce policies, and aggregate telemetry data.
*[Job]: A finite or batch task that runs to completion.
*[Kops]: A CLI tool that helps you create, destroy, upgrade and maintain production-grade, highly available, Kubernetes clusters.
*[kube-controller-manager]: Control plane component that runs controller processes.
*[kube-proxy]: kube-proxy is a network proxy that runs on each node in your cluster, implementing part of the Kubernetes Service concept.
*[kube-scheduler]: Control plane component that watches for newly created Pods with no assigned node, and selects a node for them to run on.
*[Kubeadm]: A tool for quickly installing Kubernetes and setting up a secure cluster.
*[Kubectl]: Also known as:kubectl. Command line tool for communicating with a Kubernetes cluster's control plane, using the Kubernetes API.
*[Kubelet]: An agent that runs on each node in the cluster. It makes sure that containers are running in a Pod.
*[Kubernetes API]: The application that serves Kubernetes functionality through a RESTful interface and stores the state of the cluster.
*[Label]: Tags objects with identifying attributes that are meaningful and relevant to users.
*[LimitRange]: Provides constraints to limit resource consumption per Containers or Pods in a namespace.
*[Logging]: Logs are the list of events that are logged by cluster or application.
*[Managed Service]: A software offering maintained by a third-party provider.
*[Manifest]: Specification of a Kubernetes API object in JSON or YAML format.
*[Master]: Legacy term, used as synonym for nodes hosting the control plane.
*[Member]: A continuously active contributor in the K8s community.
*[Minikube]: A tool for running Kubernetes locally.
*[Mirror Pod]: A pod object that a kubelet uses to represent a static pod
*[Name]: A client-provided string that refers to an object in a resource URL, such as /api/v1/pods/some-name.
*[Namespace]: An abstraction used by Kubernetes to support isolation of groups of resources within a single cluster.
*[Network Policy]: A specification of how groups of Pods are allowed to communicate with each other and with other network endpoints.
*[Node-pressure eviction]: Also known as:kubelet eviction. Node-pressure eviction is the process by which the kubelet proactively terminates pods to reclaim resources on nodes.
*[Node]: A node is a worker machine in Kubernetes.
*[Object]: An entity in the Kubernetes system. The Kubernetes API uses these entities to represent the state of your cluster.
*[Operator Pattern]: The operator pattern is a system design that links a Controller to one or more custom resources.
*[Persistent Volume Claim]: Claims storage resources defined in a PersistentVolume so that it can be mounted as a volume in a container.
*[Persistent Volume]: An API object that represents a piece of storage in the cluster. Available as a general, pluggable resource that persists beyond the lifecycle of any individual Pod.
*[Platform Developer]: A person who customizes the Kubernetes platform to fit the needs of their project.
*[Pod Disruption Budget]: Also known as:PDB. A Pod Disruption Budget allows an application owner to create an object for a replicated application, that ensures a certain number or percentage of Pods with an assigned label will not be voluntarily evicted at any point in time.
*[Pod Disruption]: Pod disruption is the process by which Pods on Nodes are terminated either voluntarily or involuntarily.
*[Pod Lifecycle]: The sequence of states through which a Pod passes during its lifetime.
*[Pod Priority]: Pod Priority indicates the importance of a Pod relative to other Pods.
*[Pod Security Policy]: Enables fine-grained authorization of Pod creation and updates.
*[Static Pod]: A pod managed directly by the kubelet daemon on a specific node,
*[Pod]: The smallest and simplest Kubernetes object. A Pod represents a set of running containers on your cluster.
*[Preemption]: Preemption logic in Kubernetes helps a pending Pod to find a suitable Node by evicting low priority Pods existing on that Node.
*[Proxy]: In computing, a proxy is a server that acts as an intermediary for a remote service.
*[QoS Class]: QoS Class (Quality of Service Class) provides a way for Kubernetes to classify Pods within the cluster into several classes and make decisions about scheduling and eviction.
*[Quantity]: A whole-number representation of small or large numbers using SI suffixes.
*[RBAC]: (Role-Based Access Control) Manages authorization decisions, allowing admins to dynamically configure access policies through the Kubernetes API.
*[ReplicaSet]: A ReplicaSet (aims to) maintain a set of replica Pods running at any given time.
*[ReplicationController]: A workload resource that manages a replicated application, ensuring that a specific number of instances of a Pod are running.
*[Resource Quotas]: Provides constraints that limit aggregate resource consumption per Namespace.
*[Reviewer]: A person who reviews code for quality and correctness on some part of the project.
*[Secret]: Stores sensitive information, such as passwords, OAuth tokens, and ssh keys.
*[Security Context]: The securityContext field defines privilege and access control settings for a Pod or container.
*[Selector]: Allows users to filter a list of resources based on labels.
*[Service Broker]: An endpoint for a set of Managed Services offered and maintained by a third-party.
*[Service Catalog]: An extension API that enables applications running in Kubernetes clusters to easily use external managed software offerings, such as a datastore service offered by a cloud provider.
*[Service]: An abstract way to expose an application running on a set of Pods as a network service.
*[ServiceAccount]: Provides an identity for processes that run in a Pod.
*[Shuffle-sharding]: A technique for assigning requests to queues that provides better isolation than hashing modulo the number of queues.
*[SIG]: (special interest group) Community members who collectively manage an ongoing piece or aspect of the larger Kubernetes open source project.
*[StatefulSet]: Manages the deployment and scaling of a set of Pods, and provides guarantees about the ordering and uniqueness of these Pods.
*[Storage Class]: A StorageClass provides a way for administrators to describe different available storage types.
*[sysctl]: sysctl is a semi-standardized interface for reading or changing the attributes of the running Unix kernel.
*[Taint]: A core object consisting of three required properties: key, value, and effect. Taints prevent the scheduling of Pods on nodes or node groups.
*[Toleration]: A core object consisting of three required properties: key, value, and effect. Tolerations enable the scheduling of pods on nodes or node groups that have matching taints.
*[UID]: A Kubernetes systems-generated string to uniquely identify objects.
*[Upstream]: (disambiguation) May refer to: core Kubernetes or the source repo from which a repo was forked.
*[user namespace]: A kernel feature to emulate root. Used for "rootless containers".
*[Volume Plugin]: A Volume Plugin enables integration of storage within a Pod.
*[Volume]: A directory containing data, accessible to the containers in a Pod.
*[WG]: (working group) Facilitates the discussion and/or implementation of a short-lived, narrow, or decoupled project for a committee, SIG, or cross-SIG effort.
*[Workload]: A workload is an application running on Kubernetes. -->