#!/bin/bash

# Check if Kubectl exists already.
if command -v kubectl &> /dev/null
then
    echo
    echo "Kubectl already exists."
    exit 1
fi

# Install kubectl and plugin from the ubuntu package manager.
sudo apt update
sudo apt install -y \
    curl \
    apt-transport-https \
    ca-certificates \
    gnupg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | \
    sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
    sudo tee /usr/share/keyrings/cloud.google.gpg
sudo apt update
sudo apt install -y \
    kubectl \
    google-cloud-sdk-gke-gcloud-auth-plugin

# Set environment variables.
GCLOUD_SERVICE_ACCOUNT=service-account@project-lee-1.iam.gserviceaccount.com
KEY_FILE=~/secret/gsa-key.json
PROJECT_ID=project-lee-1
CLUSTER_REGION=us-central1
CLUSTER_NAME=autopilot-cluster-1
NAMESPACE=default
CLUSTER_ROLE=cluster-admin
SERVICE_ACCOUNT=$NAMESPACE-$CLUSTER_ROLE
BINDING_NAME=$SERVICE_ACCOUNT-binding

# Authenticate with a service account. (The gcloud command cannot be executed within the folder synced by rclone.)
cd ~
gcloud auth activate-service-account $GCLOUD_SERVICE_ACCOUNT --key-file=$KEY_FILE --project=$PROJECT_ID

# Configure kubectl command line access
gcloud container clusters get-credentials $CLUSTER_NAME --region $CLUSTER_REGION --project $PROJECT_ID

# Create a service account for Sparklyr and K8sClusterManagers.
kubectl create serviceaccount $SERVICE_ACCOUNT

# Grant the admin role to the service account.
kubectl create clusterrolebinding $BINDING_NAME --clusterrole=$CLUSTER_ROLE --serviceaccount=$NAMESPACE:$SERVICE_ACCOUNT

for NAMESPACE in dask spark julia trino
do
    # Set additional environment variables based on the cluster role and namespace.
    CLUSTER_ROLE=admin
    SERVICE_ACCOUNT=$NAMESPACE-$CLUSTER_ROLE
    BINDING_NAME=$SERVICE_ACCOUNT-binding

    # Create a namespace for Dask, Sparklyr and Julia(K8sClusterManagers).
    kubectl create namespace $NAMESPACE

    # Create a service account for Sparklyr and Julia(K8sClusterManagers).
    kubectl create serviceaccount $SERVICE_ACCOUNT -n $NAMESPACE

    # Grant the admin role to the service account.
    kubectl create clusterrolebinding $BINDING_NAME --clusterrole=$CLUSTER_ROLE --serviceaccount=$NAMESPACE:$SERVICE_ACCOUNT
done
