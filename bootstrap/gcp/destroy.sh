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

destroy_k8s_cluster(){
	kops delete cluster --name dois2019.engineerto.be --state gs://dois2019-k8s-state/ --yes
}


main(){
    destroy_k8s_cluster
}

main
