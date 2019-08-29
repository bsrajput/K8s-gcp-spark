#!/usr/bin/env bash

CLUSTER_NAME=${CLUSTER_NAME:-"dois2019.engineerto.be"}
ZONES=${ZONES:-"us-east1-b"}
KOPS_STATE_STORE=${KOPS_STATE_STORE:-"gs://dois2019-k8s-state/"}
PROJECT=${PROJECT:-"dois2019"}
NODE_COUNT=${NODE_COUNT:-"2"}
NODE_SIZE=${NODE_SIZE:-"n1-standard-1"}
MASTER_SIZE=${MASTER_SIZE:-"n1-standard-1"}
TARGET=terraform
KOPS_FEATURE_FLAGS=AlphaAllowGCE
export KOPS_FEATURE_FLAGS=AlphaAllowGCE
DRY_RUN=${DRY_RUN:-"1"}

create_k8s_cluster(){
    if [ "$DRY_RUN" -eq 1 ]; then
        echo "Bootstrapping the K8s Cluster Started"
        kops create cluster --name=${CLUSTER_NAME} --zones ${ZONES} --state ${KOPS_STATE_STORE} --project=${PROJECT} --node-count=${NODE_COUNT} --node-size=${NODE_SIZE} --master-zones=${ZONES} --master-size=${MASTER_SIZE} --target=${TARGET}
        echo "Bootstrapping the K8s Cluster Done"
else
    echo "Hello! There"
    fi
}

update_k8s_cluster(){
        echo "Updating the K8s Cluster Started"
        kops update cluster --name dois2019.engineerto.be --yes --state gs://dois2019-k8s-state/
        echo "Update the K8s Cluster Done"
}

rolling_update_k8s_cluster(){
    echo "Rolling Update the K8s Cluster Started"
    kops rolling-update cluster --state gs://dois2019-k8s-state/ --cloudonly
    echo "Rolling Update the K8s Cluster Done"
}

main(){
    create_k8s_cluster
    sleep 60
    update_k8s_cluster
    sleep 60
    rolling_update_k8s_cluster
}

main
kubectl get nodes
