#!/bin/bash
# Install Istio on minikube
# ------------------------------------------------
# Author: Nhâm Chấn Vĩ - nhamchanvi@gmail.com - 6 July 2022

##
# 
##
minikube start

##
# 
##
minikube addons enable ingress

##
# Add istioctl binary into PATH
##
export PATH=/Users/vi/DevSecOps/demo/istio/istio-1.14.1/bin:$PATH

##
# Install Istio
##
istioctl install --set profile=demo -y

##
# Verify Istio install
##
istioctl verify-install

##
# Label the specific namespace for istio injection
##
kubectl label namespace default istio-injection=enabled

##
# Analyze the istio injection
##
istioctl analyze

##
# Install bookinfo deployments, services
##
kubectl apply -f /Users/vi/DevSecOps/demo/istio/istio-1.14.1/samples/bookinfo/platform/kube/bookinfo.yaml

##
# Install sample addons (kiali, prometheus, grafana, jaeger)
##
kubectl apply -f /Users/vi/DevSecOps/demo/istio/istio-1.14.1/samples/addons

# ##
# # Start Kiali dashboard
# ##
# istioctl dashboard kiali

# ##
# # Create a Gateway and its virtual service
# ##
# kubectl apply -f /Users/vi/DevSecOps/demo/istio/istio-1.14.1/samples/bookinfo/networking/bookinfo-gateway.yaml

# ##
# # Export the minukube IP to our variable
# ##
# export INGRESS_HOST=$(minikube ip)

# ##
# # Export the minukube IP to our variable
# ##
# export INGRESS_PORT=$(kubectl -n istio-system get svc istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')


##
# Create gateway to capture coming traffic through URL bookinf.app then through istio-ingressgateway
##
cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: bookinfo-gateway
spec:
  selector:
    istio: ingressgateway # use istio default istio-ingressgateway controller
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "*"
EOF

##
# Create a virtual service 
##
cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: bookinfo
spec:
  hosts:
  - "bookinfo.app"
  gateways:
  - bookinfo-gateway
  http:
  - match:
    - uri:
        exact: /productpage
    - uri:
        prefix: /static
    - uri:
        exact: /login
    - uri:
        exact: /logout
    - uri:
        prefix: /api/v1/products
    route:
    - destination:
        host: productpage
        port:
          number: 9080
EOF


