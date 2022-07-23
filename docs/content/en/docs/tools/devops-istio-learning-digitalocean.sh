#!/bin/bash
# Install Istio on DigitalOcean
# ------------------------------------------------
# Author: Nhâm Chấn Vĩ - nhamchanvi@gmail.com - 7 July 2022

##
# Add istioctl binary into PATH
##
cd /Users/vi/DevSecOps/demo/istio/istio-1.14.1
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

##
# Create a Gateway and its virtual service
##
kubectl apply -f /Users/vi/DevSecOps/demo/istio/istio-1.14.1/samples/bookinfo/networking/bookinfo-gateway.yaml

##
# Define application version by using destination rules
##
kubectl apply -f /Users/vi/DevSecOps/demo/istio/istio-1.14.1/samples/bookinfo/networking/destination-rule-all.yaml

##
# Create reviews virtual service with weight
##
cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: reviews
spec:
  hosts:
    - reviews
  http:
  - route:
    - destination:
        host: reviews
        subset: v1
      weight: 75
    - destination:
        host: reviews
        subset: v2
      weight: 25
EOF

##
# Update reviews virtual service with weight
##
cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: reviews
spec:
  hosts:
    - reviews
  http:
  - route:
    - destination:
        host: reviews
        subset: v1
      weight: 60
    - destination:
        host: reviews
        subset: v2
      weight: 20
    - destination:
        host: reviews
        subset: v3
      weight: 20
EOF

##
# Update reviews virtual service with weight
##
cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: reviews
spec:
  hosts:
    - reviews
  http:
  - match:
    - headers:
        end-user:
          exact: chanvi
    route:
    - destination:
        host: reviews
        subset: v3
  - route:
    - destination:
        host: reviews
        subset: v1
      weight: 60
    - destination:
        host: reviews
        subset: v2
      weight: 40
EOF

##
# 
##
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: reviews
  labels:
    app: reviews
    service: reviews
    test: beta
spec:
  ports:
  - port: 9080
    name: http
  selector:
    app: reviews
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: bookinfo-reviews
  labels:
    account: reviews
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: reviews-v1
  labels:
    app: reviews
    version: v1
spec:
  replicas: 1
  selector:
    matchLabels:
      app: reviews
      version: v1
  template:
    metadata:
      labels:
        app: reviews
        version: v1
    spec:
      serviceAccountName: bookinfo-reviews
      containers:
      - name: reviews
        image: docker.io/istio/examples-bookinfo-reviews-v1:1.16.4
        imagePullPolicy: IfNotPresent
        env:
        - name: LOG_DIR
          value: "/tmp/logs"
        ports:
        - containerPort: 9080
        volumeMounts:
        - name: tmp
          mountPath: /tmp
        - name: wlp-output
          mountPath: /opt/ibm/wlp/output
        securityContext:
          runAsUser: 1000
      volumes:
      - name: wlp-output
        emptyDir: {}
      - name: tmp
        emptyDir: {}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: reviews-v2
  labels:
    app: reviews
    version: v2
    test: beta
spec:
  replicas: 1
  selector:
    matchLabels:
      app: reviews
      version: v2
      test: beta
  template:
    metadata:
      labels:
        app: reviews
        version: v2
        test: beta
    spec:
      serviceAccountName: bookinfo-reviews
      containers:
      - name: reviews
        image: docker.io/istio/examples-bookinfo-reviews-v2:1.16.4
        imagePullPolicy: IfNotPresent
        env:
        - name: LOG_DIR
          value: "/tmp/logs"
        ports:
        - containerPort: 9080
        volumeMounts:
        - name: tmp
          mountPath: /tmp
        - name: wlp-output
          mountPath: /opt/ibm/wlp/output
        securityContext:
          runAsUser: 1000
      volumes:
      - name: wlp-output
        emptyDir: {}
      - name: tmp
        emptyDir: {}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: reviews-v3
  labels:
    app: reviews
    version: v3
    test: beta
spec:
  replicas: 1
  selector:
    matchLabels:
      app: reviews
      version: v3
      test: beta
  template:
    metadata:
      labels:
        app: reviews
        version: v3
        test: beta
    spec:
      serviceAccountName: bookinfo-reviews
      containers:
      - name: reviews
        image: docker.io/istio/examples-bookinfo-reviews-v3:1.16.4
        imagePullPolicy: IfNotPresent
        env:
        - name: LOG_DIR
          value: "/tmp/logs"
        ports:
        - containerPort: 9080
        volumeMounts:
        - name: tmp
          mountPath: /tmp
        - name: wlp-output
          mountPath: /opt/ibm/wlp/output
        securityContext:
          runAsUser: 1000
      volumes:
      - name: wlp-output
        emptyDir: {}
      - name: tmp
        emptyDir: {}
EOF

##
# 
##
cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: reviews
spec:
  host: reviews
  subsets:
  - name: v1
    labels:
      version: v1
  - name: test
    labels:
      test: beta
EOF

##
# 
##
cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: reviews
spec:
  hosts:
    - reviews
  http:
  - route:
    - destination:
        host: reviews
        subset: v1
      weight: 50
    - destination:
        host: reviews
        subset: test
      weight: 50
EOF

##
# Create VS for details for fault injection
##
cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: details
spec:
  hosts:
    - details
  http:
  - fault:
      delay:
        percentage:
          value: 70.0 # 70% of traffic will be delayed for an extra 7 seconds
        fixedDelay: 7s
    route:
    - destination:
        host: details
        subset: v1
EOF

##
# Clean up all default workload, reinstall the bookinfo deployments
##
cd /Users/vi/DevSecOps/demo/istio/istio-1.14.1
./samples/bookinfo/platform/kube/cleanup.sh
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml

##
# Create new namespace and deploy HTTPBin with manually inject Istio proxy sidecar. 
##
kubectl create ns bar
kubectl apply -f <(istioctl kube-inject -f samples/httpbin/httpbin.yaml) -n bar

##
# Curl from HTTPbin to a productpage ==> it is able to curl from httpbin in bar namespace to proudctpage in default namespace
##
kubectl exec -it "$(kubectl get pod -l app=httpbin -n bar -o jsonpath={.items..metadata.name})" -c istio-proxy -n bar -- curl "http://productpage.default:9080" -s -o /dev/null -w "%{http_code}\n"

##
# Apply the Peer Authentication for default namespace mTLS mode strict
##
cat <<EOF | kubectl apply -f -
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: peer-policy
  namespace: default
spec:
  mtls:
    mode: STRICT
EOF

##
# Curl from HTTPbin to a productpage ==> it is NOT able to curl from httpbin in bar namespace to proudctpage in default namespace
##
kubectl exec -it "$(kubectl get pod -l app=httpbin -n bar -o jsonpath={.items..metadata.name})" -c istio-proxy -n bar -- curl "http://productpage.default:9080" -s -o /dev/null -w "%{http_code}\n"


##
# Create an authorization policy for default namespace, since this has no selector, it will affect the whole default namespace and the spec section has empty value so it will not permit any traffic and all requests will be deined.
##
cat <<EOF | kubectl apply -f -
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: allow-nothing
  namespace: default # as spec section has no selector so this is namespace-wide policy
spec: 
  {} # spec section is empty so that will not permit any traffic and all requests will be deined.
EOF

##
# Create an authorization policy for productpage
##
cat <<EOF | kubectl apply -f -
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: productpage-viewer
  namespace: default 
spec: 
  selector:
    matchLabels:
      app: productpage
  action: ALLOW
  rules:
  - to: 
    - operation:
        methods: ["GET"] # configured for traffic coming to the service
EOF

##
# Create an authorization policy for details service
##
cat <<EOF | kubectl apply -f -
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: details-viewer
  namespace: default 
spec: 
  selector:
    matchLabels:
      app: details
  action: ALLOW
  rules:
  - from:
    - source:
        principals: ["cluster.local/ns/default/sa/bookinfo-productpage"] # allow traffic coming from service account bookinfo-productpage
  - to: 
    - operation:
        methods: ["GET"] # access details service through GET methods
EOF

##
# Create an authorization policy for reviews service
##
cat <<EOF | kubectl apply -f -
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: reviews-viewer
  namespace: default 
spec: 
  selector:
    matchLabels:
      app: reviews
  action: ALLOW
  rules:
  - from:
    - source:
        principals: ["cluster.local/ns/default/sa/bookinfo-productpage"] # allow traffic coming from service account bookinfo-productpage
  - to: 
    - operation:
        methods: ["GET"] # access details service through GET methods
EOF

##
# Create an authorization policy for ratings service
##
cat <<EOF | kubectl apply -f -
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: ratings-viewer
  namespace: default 
spec: 
  selector:
    matchLabels:
      app: ratings
  action: ALLOW
  rules:
  - from:
    - source:
        principals: ["cluster.local/ns/default/sa/bookinfo-reviews"] # allow traffic coming from service account bookinfo-productpage
  - to: 
    - operation:
        methods: ["GET"] # access details service through GET methods
EOF

##
# Create a folder for our certificates in Istio root directory
##
mkdir ca-certs
cd ca-certs

##
# Generate root certificate 
##
make -f ../tools/certs/Makefile.selfsigned.mk root-ca