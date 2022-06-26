---
hide:
  - tags
tags:
  - service mesh
---

# Overview

<!-- set the topic's context with a single paragraph. -->
Service Mesh introduction

## Body

<!-- explain the concept. -->
- Single proxy in the form of a sidecar container to replace all the different requirements into each microservice. The proxies communicate with each other through what is known as a data plane and they communicate to a server site component called control plane.
- Control plane manages all the traffic into and out of your services via proxies, so all the networking logic is abstracted from your business code. This approach is known as a Service Mesh.

### What is Service Mesh?

Service Mesh is a dedicated and configurable infrastructure layer that handles the communication between services without having to change the code in a microservice architecture.

### What is Service Mesh Responsible For?

- With the Service Mesh, you can dynamically configure how services talk to each other.
- When services talk to one another, you'll have mutual TLS, so your workloads can be secure. You can see thing better

## Whatsnext

<!-- provide a bulleted list of topics (5 maximum) to learn more about the concept. -->
