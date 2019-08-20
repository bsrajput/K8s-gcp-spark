#!/usr/bin/env bash
CURDIR="$( cd "$( dirname "$0" )" && pwd )"
source $CURDIR/envs
kops create cluster --node-count ${NODE_COUNT} --node-size ${NODE_SIZE} --master-size ${MASTER_SIZE} --master-count ${MASTER_COUNT} --master-zones ${ZONES} --cloud-labels "ManagedBy=abhishek,service=k8s" --topology private --api-loadbalancer-type internal --networking flannel --bastion=true --zones ${ZONES} --out=$CURDIR/terraform --target=terraform $CLUSTER_NAME --state ${KOPS_STATE_STORE}/ --project ${PROJECT} --image ${IMAGE}
