---
hide:
  - tags
tags:
  - task
---

# Production Deployment

This page shows how to deploy the Beincomm in production environment.

## Before you begin

You need to have:

* A managed Kubernetes cluster for backend services managed Kubernetes cluster for Kafka cluster.
* A managed PostgeSQL and Redis database.
* Accessible to ALL the related source codes, CircleCI, AWS environment, 3rd party software such as SendGrid, Sentry, NewRelic,...
* Accessible to DevOps configuration files repository
* kubectl, aws, doppler command-line tool

## Pre-requisites

Clone the configuration files and move to the cloned folder

```sh
git clone git@github.com:bicdevops/production-may-2022.git
cd production-may-2022
```

The output is similar to this:

```sh
cd production-may-2022
Cloning into 'production-may-2022'...
remote: Enumerating objects: 2987, done.
remote: Total 2987 (delta 0), reused 0 (delta 0), pack-reused 2987
Receiving objects: 100% (2987/2987), 45.98 MiB | 6.36 MiB/s, done.
Resolving deltas: 100% (1085/1085), done.
Updating files: 100% (3381/3381), done.
```

---

## Pre-deployment

### Clean up unnecessary Kubernetes resources

Delete **Bein Feed** deployment and service in Kubernetes cluster

```sh
kubectl delete deployment bein-feed-backend-api
kubectl delete service bein-feed-backend-api
```

The output is similar to this:

```sh
deployment.apps "bein-feed-backend-api" deleted
service "bein-feed-backend-api" deleted
```

Delete **Bein Mattermost** deployment and service in Kubernetes cluster

```sh
kubectl delete deployment bein-mattermost-backend-api
kubectl delete service bein-mattermost-backend-api
```

The output is similar to this:

```sh
deployment.apps "bein-mattermost-backend-api" deleted
service "bein-mattermost-backend-api" deleted
```

### Clean up all data on Redis

Follow the best practice to clean up data

### Clean up all data on AWS Cognito

Follow the best practice to clean up data

### Clean up all data on ElasticSearch

Follow the best practice to clean up data

### Create Doppler secrets

Install Doppler CLI and login to Doppler via website

```sh
./doppler/doppler_1_install_cli_and_login.sh
```

Info "Information when using `doppler login`"

1. Overwrite global login (/) **/**
2. Open the authorization page in your browser? (Y/n) **Y**
3. Paste the **auth code** into the Doppler website
4. Choose **BIC** Workplace

The output is similar to this:

```sh
Warning: gnupg 2.3.6 is already installed, it's just not linked.
To link this version, run:
    brew link gnupg
Warning: dopplerhq/cli/doppler 3.40.0 is already installed, it's just not linked.
To link this version, run:
    brew link doppler
Warning: You have already logged in.

Would you like to scope your new login to the current directory, or overwrite the existing global login?
? Select an option: Scope login to current directory (/Users/vi/BICDevOps/production-may-2022)
Overwrite global login (/) /
? Open the authorization page in your browser? Yes
Complete authorization at https://dashboard.doppler.com/workplace/auth/cli
Your auth code is:
*********_elderberry_stegosaurus_chili_cinnamon

Waiting...

Welcome, Nhâm
```

Install `Doppler Kubernetes Operator` with manifest file

```sh
./doppler/doppler_2_install_kubernetes_operator.sh
```

The output is similar to this:

```sh
namespace/bic-doppler-operator-system created
customresourcedefinition.apiextensions.k8s.io/dopplersecrets.secrets.doppler.com created
serviceaccount/doppler-operator-controller-manager created
role.rbac.authorization.k8s.io/doppler-operator-leader-election-role created
clusterrole.rbac.authorization.k8s.io/doppler-operator-manager-role created
clusterrole.rbac.authorization.k8s.io/doppler-operator-metrics-reader created
clusterrole.rbac.authorization.k8s.io/doppler-operator-proxy-role created
rolebinding.rbac.authorization.k8s.io/doppler-operator-leader-election-rolebinding created
clusterrolebinding.rbac.authorization.k8s.io/doppler-operator-manager-rolebinding created
clusterrolebinding.rbac.authorization.k8s.io/doppler-operator-proxy-rolebinding created
configmap/doppler-operator-manager-config created
service/doppler-operator-controller-manager-metrics-service created
deployment.apps/doppler-operator-controller-manager created
```

Create Doppler secrets - this will create all secrets to connect to Doppler

```sh
./doppler/doppler_3_setup_secrets.sh
```

The output is similar to this:

```sh
secret/bic-chat-pro-doppler-token-secret created
dopplersecret.secrets.doppler.com/bic-chat-pro-doppler-secret created
secret/bic-comm-pro-doppler-token-secret created
dopplersecret.secrets.doppler.com/bic-comm-pro-doppler-secret created
secret/bic-stream-pro-doppler-token-secret created
dopplersecret.secrets.doppler.com/bic-stream-pro-doppler-secret created
secret/bic-notification-pro-doppler-token-secret created
dopplersecret.secrets.doppler.com/bic-notification-pro-doppler-secret created
secret/bic-upload-kaltura-pro-doppler-token-secret created
dopplersecret.secrets.doppler.com/bic-upload-kaltura-pro-doppler-secret created
secret/bic-upload-manage-pro-doppler-token-secret created
dopplersecret.secrets.doppler.com/bic-upload-manage-pro-doppler-secret created
```

### Create self-host Kafka Kubernetes cluster in DigitalOcean

Create Kubernetes cluster name: `bein-pro-sgp1-k8s-kafka-cluster`

With node pool and capacities

| Node pool              |    Capacity    | # of node |
| ---------------------- | :------------: | :-------: |
| kafka-pro-basic40-pool | 4vCPU, 8GB RAM |     1     |
| kafka-pro-10-pool      | 1vCPU, 2GB RAM |     2     |

Create Kafka Kubernetes cluster

```sh
./kafka/kafka_1_nodeport_cluster_SCRAM.sh
```

The output is similar to this:

```sh
namespace/kafka created
    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                Dload  Upload   Total   Spent    Left  Speed
    0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100  751k  100  751k    0     0   334k      0  0:00:02  0:00:02 --:--:-- 2231k
customresourcedefinition.apiextensions.k8s.io/strimzipodsets.core.strimzi.io created
customresourcedefinition.apiextensions.k8s.io/kafkausers.kafka.strimzi.io created
customresourcedefinition.apiextensions.k8s.io/kafkas.kafka.strimzi.io created
clusterrole.rbac.authorization.k8s.io/strimzi-cluster-operator-namespaced created
clusterrole.rbac.authorization.k8s.io/strimzi-kafka-broker created
customresourcedefinition.apiextensions.k8s.io/kafkaconnects.kafka.strimzi.io created
customresourcedefinition.apiextensions.k8s.io/kafkaconnectors.kafka.strimzi.io created
deployment.apps/strimzi-cluster-operator created
customresourcedefinition.apiextensions.k8s.io/kafkarebalances.kafka.strimzi.io created
rolebinding.rbac.authorization.k8s.io/strimzi-cluster-operator created
clusterrole.rbac.authorization.k8s.io/strimzi-cluster-operator-global created
customresourcedefinition.apiextensions.k8s.io/kafkabridges.kafka.strimzi.io created
customresourcedefinition.apiextensions.k8s.io/kafkamirrormaker2s.kafka.strimzi.io created
rolebinding.rbac.authorization.k8s.io/strimzi-cluster-operator-entity-operator-delegation created
clusterrole.rbac.authorization.k8s.io/strimzi-kafka-client created
clusterrolebinding.rbac.authorization.k8s.io/strimzi-cluster-operator-kafka-client-delegation created
clusterrolebinding.rbac.authorization.k8s.io/strimzi-cluster-operator created
customresourcedefinition.apiextensions.k8s.io/kafkatopics.kafka.strimzi.io created
clusterrolebinding.rbac.authorization.k8s.io/strimzi-cluster-operator-kafka-broker-delegation created
configmap/strimzi-cluster-operator created
clusterrole.rbac.authorization.k8s.io/strimzi-entity-operator created
customresourcedefinition.apiextensions.k8s.io/kafkamirrormakers.kafka.strimzi.io created
serviceaccount/strimzi-cluster-operator created
kafka.kafka.strimzi.io/my-cluster created
kafkatopic.kafka.strimzi.io/my-topic created
secret/bic-comm-pro-kafka-secret created
kafkauser.kafka.strimzi.io/bic-comm-pro-kafka-user created
secret/bic-chat-pro-kafka-secret created
kafkauser.kafka.strimzi.io/bic-chat-pro-kafka-user created
secret/bic-stream-pro-kafka-secret created
kafkauser.kafka.strimzi.io/bic-stream-pro-kafka-user created
secret/bic-notification-pro-kafka-secret created
kafkauser.kafka.strimzi.io/bic-notification-pro-kafka-user created
secret/kafka-test-secret created
kafkauser.kafka.strimzi.io/kafka-test created

NAME                                        READY   STATUS              RESTARTS   AGE
strimzi-cluster-operator-585f6fd9d7-8vm59   0/1     ContainerCreating   0          8s
strimzi-cluster-operator-585f6fd9d7-8vm59   0/1     Running             0          17s
strimzi-cluster-operator-585f6fd9d7-8vm59   1/1     Running             0          31s
my-cluster-zookeeper-0                      0/1     Pending             0          0s
my-cluster-zookeeper-1                      0/1     Pending             0          0s
my-cluster-zookeeper-0                      0/1     Pending             0          0s
my-cluster-zookeeper-1                      0/1     Pending             0          0s
my-cluster-zookeeper-2                      0/1     Pending             0          0s
my-cluster-zookeeper-2                      0/1     Pending             0          0s
my-cluster-zookeeper-1                      0/1     Pending             0          4s
my-cluster-zookeeper-1                      0/1     ContainerCreating   0          4s
my-cluster-zookeeper-0                      0/1     Pending             0          8s
my-cluster-zookeeper-2                      0/1     Pending             0          8s
my-cluster-zookeeper-0                      0/1     ContainerCreating   0          8s
my-cluster-zookeeper-2                      0/1     ContainerCreating   0          8s
my-cluster-zookeeper-1                      0/1     Running             0          29s
my-cluster-zookeeper-2                      0/1     Running             0          29s
my-cluster-zookeeper-0                      0/1     Running             0          30s
my-cluster-zookeeper-1                      1/1     Running             0          45s
my-cluster-zookeeper-0                      1/1     Running             0          49s
my-cluster-zookeeper-2                      1/1     Running             0          49s
my-cluster-kafka-0                          0/1     Pending             0          0s
my-cluster-kafka-1                          0/1     Pending             0          0s
my-cluster-kafka-0                          0/1     Pending             0          0s
my-cluster-kafka-2                          0/1     Pending             0          0s
my-cluster-kafka-1                          0/1     Pending             0          0s
my-cluster-kafka-2                          0/1     Pending             0          0s
my-cluster-kafka-0                          0/1     Pending             0          4s
my-cluster-kafka-2                          0/1     Pending             0          4s
my-cluster-kafka-0                          0/1     Init:0/1            0          4s
my-cluster-kafka-2                          0/1     Init:0/1            0          4s
my-cluster-kafka-1                          0/1     Pending             0          8s
my-cluster-kafka-1                          0/1     Init:0/1            0          8s
my-cluster-kafka-2                          0/1     Init:0/1            0          18s
my-cluster-kafka-2                          0/1     PodInitializing     0          21s
my-cluster-kafka-2                          0/1     Running             0          22s
my-cluster-kafka-0                          0/1     Init:0/1            0          26s
my-cluster-kafka-1                          0/1     Init:0/1            0          29s
my-cluster-kafka-0                          0/1     PodInitializing     0          34s
my-cluster-kafka-0                          0/1     Running             0          35s
my-cluster-kafka-1                          0/1     PodInitializing     0          39s
my-cluster-kafka-1                          0/1     Running             0          40s
my-cluster-kafka-2                          1/1     Running             0          55s
my-cluster-kafka-1                          1/1     Running             0          68s
my-cluster-kafka-0                          1/1     Running             0          75s
my-cluster-entity-operator-58f4844c45-nqdxs   0/3     Pending             0          0s
my-cluster-entity-operator-58f4844c45-nqdxs   0/3     Pending             0          0s
my-cluster-entity-operator-58f4844c45-nqdxs   0/3     ContainerCreating   0          0s
my-cluster-entity-operator-58f4844c45-nqdxs   0/3     Running             0          18s
my-cluster-entity-operator-58f4844c45-nqdxs   1/3     Running             0          22s
my-cluster-entity-operator-58f4844c45-nqdxs   1/3     Running             0          22s
my-cluster-entity-operator-58f4844c45-nqdxs   2/3     Running             0          40s
my-cluster-entity-operator-58f4844c45-nqdxs   3/3     Running             0          50s
```

Export all client certificates and `scram` credentials

```sh
cd kafka
./kafka_2_export_certificates.sh
ls -la
```

The output is similar to this:

```sh
total 152
drwxr-xr-x  20 vi  staff   640 Jun  7 09:34 .
drwxr-xr-x  49 vi  staff  1568 Jun  7 14:14 ..
-rw-r--r--   1 vi  staff   152 Jun  7 14:18 bic-chat-pro-kafka-user.config
-rw-r--r--   1 vi  staff    40 Jun  7 14:18 bic-chat-pro-kafka-user.password
-rw-r--r--   1 vi  staff   152 Jun  7 14:18 bic-comm-pro-kafka-user.config
-rw-r--r--   1 vi  staff    40 Jun  7 14:18 bic-comm-pro-kafka-user.password
-rw-r--r--   1 vi  staff   160 Jun  7 14:18 bic-notification-pro-kafka-user.config
-rw-r--r--   1 vi  staff    40 Jun  7 14:18 bic-notification-pro-kafka-user.password
-rw-r--r--   1 vi  staff   154 Jun  7 14:18 bic-stream-pro-kafka-user.config
-rw-r--r--   1 vi  staff    40 Jun  7 14:18 bic-stream-pro-kafka-user.password
-rw-r--r--   1 vi  staff  1854 Jun  7 14:18 ca.crt
-rw-r--r--   1 vi  staff  1687 Jun  7 14:18 ca.p12
-rw-r--r--   1 vi  staff    12 Jun  7 14:18 ca.password
-rw-r--r--   1 vi  staff  1854 Jun  7 14:18 client-cert.pem
-rw-r--r--   1 vi  staff  3272 Jun  7 14:18 client-key.pem
-rw-r--r--   1 vi  staff  1441 Jun  7 09:34 docker-compose.yml
-rw-r--r--   1 vi  staff   107 Jun  7 14:18 kafka-test.config
-rw-r--r--   1 vi  staff     8 Jun  7 14:18 kafka-test.password
-rwxr-xr-x   1 vi  staff  5099 Jun  7 09:34 kafka_1_nodeport_cluster_SCRAM.sh
-rwxr-xr-x   1 vi  staff  3078 Jun  7 09:34 kafka_2_export_certificates.sh
```

### Create NewRelic API key and Fluentd on Kubernetes cluster

#### Create NewRelic API key

1. Access <https://one.newrelic.com/launcher/api-keys-ui.api-keys-launcher>
2. **Create a key**
3. Choose **Key type**: **Ingest - License**
4. **Name**: **k8s log**
5. Click **Create a key**
6. Create base64 encoded format for the newly generated API key and update the `data.LICENSE_KEY` in the secret object in `newrelic_1_install_fluentd_components.sh` script

Encode base64 the license key above

```sh
echo -n 'content-of-the-new-API-key' | base64
Y29udGVudC1vZi10aGUtbmV3LUFQSS1rZXk=
```

Insert the base64 encoded output to the `data.LICENCE_KEY `

```sh
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: fluentd-aggregation
  namespace: kube-system
data:
  BASE_URI: # content hide
  LICENSE_KEY: Y29udGVudC1vZi10aGUtbmV3LUFQSS1rZXk= # <== paste here
EOF
```

The output is similar to this:

```sh
secret/fluentd-aggregation created
```

#### Install Fluentd on Kubernetes cluster

Switch to Production Kubernetes cluster

```sh
kubectl config use-context do-k8s-production
```

The output is similar to this:

```sh
Switched to context "do-k8s-production".
```

Install Fluentd aggregation

```sh
./newrelic/newrelic_1_install_fluentd_components.sh
```

The output is similar to this:

```sh
daemonset.apps/fluentd-agent created
clusterrole.rbac.authorization.k8s.io/fluentd created
clusterrolebinding.rbac.authorization.k8s.io/fluentd created
configmap/fluentd-aggregation-config created
deployment.apps/fluentd-aggregation created
secret/fluentd-aggregation configured
service/fluentd-aggregation created
serviceaccount/fluentd created
```

Update the Ingress log format

```sh
./newrelic/newrelic_2_update_ingress_log_format.sh
```

The output is similar to this:

```sh
configmap/ingress-nginx-controller created
```

### Create SendGrid API key and verify sender email

## Bein Chat Deployment

### Drop Postgres all tables

### Deploy Chat backend and Chat frontend in Kubernetes cluster

Switch to Production Kubernetes cluster

```sh
kubectl config use-context do-k8s-production
```

The output is similar to this:

```sh
Switched to context "do-k8s-production".
```

Create PVCs for Chat

```sh
./chat/chat_1_create_pvc.sh
```

The output is similar to this:

```sh
persistentvolumeclaim/do-vol-mattermost-data-pvc created
persistentvolumeclaim/do-vol-mattermost-plugins-pvc created
persistentvolumeclaim/do-vol-mattermost-client-plugins-pvc created
persistentvolumeclaim/do-vol-mattermost-config-pvc created
```

Deploy CI/CD job to branch `master` for `bein-mattermost-server` and `bein-chat-web` source code

Upload the updated config.json file to newly deployed Chat server

```sh
./chat/chat_2_copy_config_file.sh
```

Restart the Chat server by delete the running Pod (example name `bein-mattermost-7b67589799-kihj5`)

```sh
kubectl rollout restart deployment bein-mattermost
```

The output is similar to this:

```sh
deployment.apps/bein-mattermost restarted
```

Verify the new Chat server Pod is in `Running` state

```sh
kubectl get pod
```

The output is similar to this:

```sh
NAME                                            READY   STATUS             RESTARTS   AGE
bein-mattermost-674db8c96d-twcl5                0/1     Terminating        0          4h19m
bein-mattermost-7bbbb64d64-b7t82                1/1     Running            0          12s
```

### Create Chat System Admin

Follow the instruction below:

https://app.clickup.com/3649385/v/dc/3fbv9-16924/3fbv9-21065
### Upload Chat plugins

Follow the instruction below:

https://app.clickup.com/3649385/v/dc/3fbv9-16924/3fbv9-24907

### Setup SendGrid email on Chat

### Setup Push Notification Proxy on Kubernetes cluster

Install Push Notification Proxy

```sh
./chat/chat_3_install_push_notification_proxy.sh
```

The output is similar to this:

```sh
configmap/mattermost-push-noti-configmap created
service/bein-mattermost-push-noti-proxy created
deployment.apps/bein-mattermost-push-noti-proxy created
```

https://app.clickup.com/3649385/v/dc/3fbv9-16924/3fbv9-20125

### Deploy Chat app

## Bein Comm Deployment

### Truncate old Postgres data

### Deploy Comm backend

1. Update environment variables of `bic-comm` **Production** environment on Doppler
2. Merge code of `bein-backend` repository from `staging` to `master` branch
### Deploy Comm web

### Deploy Comm app

### Deploy Comm web staff

## Bein Stream Deployment

### Deploy Stream backend

1. Update environment variables of `bic-stream` **Production** environment on Doppler
2. Merge code of `bein-stream` repository from `staging` to `master` branch

### Create bein_stream schema in Postgres

Create `bein_stream` schema

![Screenshot](images/bic/stream-postgres-create-schema.png)

## Bein Notification Deployment

### Deploy Notification backend

1. Update environment variables of `bic-stream` **Production** environment on Doppler
2. Merge code of `bein-stream` repository from `staging` to `master` branch

### Create bein_notification schema in Postgres

Create `bein_notification` schema

![Screenshot](images/bic/notification-postgres-create-schema.png)

## Post-deployment

### Update Ingress Controller resources in Kubernetes cluster

Update Ingress Controller resources

```sh
./nginx-ingress/ingress_1_update_ingress.sh
```

The output is similar to this:

```sh
ingress.networking.k8s.io/bein-group-ingress configured
```

### Create Super Admin and BIC Team accounts

### Create Communities and Groups

## Bein Upload Deployment

### Bein Upload Kaltura Deployment

1. Update environment variables of `bic-upload-kaltura` **Production** environment on Doppler
2. Merge code of `bein-upload-kaltura` repository from `staging` to `master` branch

### Bein Upload Manage Deployment

1. Update environment variables of `bic-upload-manage` **Production** environment on Doppler
2. Merge code of `bein-upload-manage` repository from `staging` to `master` branch

## API Gateway (APISIX)

Create APISIX and APISIX Ingress Controller

```sh
./apisix/apisix_1_install_apisix_and_ingress_controller.sh
```

The output is similar to this:

```sh
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "apisix" chart repository
Update Complete. ⎈Happy Helming!⎈
NAME: apisix
LAST DEPLOYED: Thu Jun 23 15:49:53 2022
NAMESPACE: ingress-apisix
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
1. Get the application URL by running these commands:
     NOTE: It may take a few minutes for the LoadBalancer IP to be available.
           You can watch the status of by running 'kubectl get --namespace ingress-apisix svc -w apisix-gateway'
  export SERVICE_IP=$(kubectl get svc --namespace ingress-apisix apisix-gateway --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")
  echo http://$SERVICE_IP:80
```

Create APISIX-Dashboard

```sh
./apisix/apisix_2_install_apisix_dashboard.sh
```

The output is similar to this:

```sh
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "apisix" chart repository
Update Complete. ⎈Happy Helming!⎈
NAME: apisix-dashboard
LAST DEPLOYED: Thu Jun 23 15:50:15 2022
NAMESPACE: ingress-apisix
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace ingress-apisix -l "app.kubernetes.io/name=apisix-dashboard,app.kubernetes.io/instance=apisix-dashboard" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace ingress-apisix $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace ingress-apisix port-forward $POD_NAME 8080:$CONTAINER_PORT
```

Update APISIX configuration to include the cognito-auth plugin

```sh
./apisix/apisix_3_update_apisix_config.sh
```

Update APISIX-Dashboard configuration to include the cognito-auth plugin

```sh
./apisix/apisix_4_update_apisix_dashboard_config.sh 
```

Create APISIX routess by APISIX ingress resource

```sh
./apisix/apisix_5_create_apisix_routes_by_ingress_controller.sh
```

The output is similar to this:

```sh
ingress.networking.k8s.io/bic-apisix-ingress created
```


To create an IAM OIDC identity provider for your cluster with the AWS Management Console

1. Open the Amazon EKS console at https://console.aws.amazon.com/eks/home#/clusters.

2. Select the name of your cluster.

3. In the Details section on the Overview tab, note the value of the OpenID Connect provider URL.

4. Open the IAM console at https://console.aws.amazon.com/iam/.

5. In the left navigation pane, choose Identity Providers under Access management. If a Provider is listed that matches the URL for your cluster, then you already have a provider for your cluster. If a provider isn't listed that matches the URL for your cluster, then you must create one.

6. To create a provider, choose Add Provider.

7. For Provider Type, choose OpenID Connect.

8. For Provider URL, paste the OIDC issuer URL for your cluster, and then choose Get thumbprint.

9. For Audience, enter sts.amazonaws.com and choose Add provider.