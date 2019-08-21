#!/usr/bin/env bash
CURDIR="$( cd "$( dirname "$0" )" && pwd )"
source $CURDIR/envs

kops create cluster --name=${CLUSTER_NAME} --zones ${ZONES} --state ${KOPS_STATE_STORE} --project=${PROJECT}
