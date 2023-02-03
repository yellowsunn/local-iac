#!/usr/bin/env bash
bin_path="/usr/local/bin"


# install metrics-server:3.8.3 by helm
$bin_path/helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
$bin_path/helm repo update

$bin_path/helm install metrics-server metrics-server/metrics-server \
    --create-namespace \
    --namespace=kube-system \
    -f metric_server_override.yaml \
    --version 3.8.3
