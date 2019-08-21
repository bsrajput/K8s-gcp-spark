#!/usr/bin/env bash
CURDIR="$( cd "$( dirname "$0" )" && pwd )"
source $CURDIR/envs

kops create cluster --name=${CLUSTER_NAME} --zones ${ZONES} --state ${KOPS_STATE_STORE} --project=${PROJECT} --node-count=${NODE_COUNT} --node-size=${NODE_SIZE} --master-zones=${ZONES} --master-size=${MASTER_SIZE} --target=${TARGET}
