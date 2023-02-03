#!/usr/bin/env bash

# install metrics-server:3.8.3 by helm
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
helm repo update

helm install metrics-server metrics-server/metrics-server \
    --create-namespace \
    --namespace=kube-system \
    --set hostNetwork.enabled=true \
    --set args={--kubelet-insecure-tls} \
    --version 3.8.3
