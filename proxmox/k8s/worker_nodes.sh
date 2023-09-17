#/user/bin/env bash

## configuration variables ##
# max number of worker nodes
N = 3 
# each of components to install 
k8s_V    = '1.28.1'           # Kubernetes 
ctrd_V   = '1.6.21-3.1.el7'   # Containerd 
docker_V = '24.0.2-1.el7'     # Docker  
# master node ip
m_node_ip = '192.168.0.151'
## /configuration variables ##

sh ./scripts/k8s_env_build.sh $N $m_node_ip
sh ./scripts/k8s_pkg_cfg.sh $k8s_V $docker_V $ctrd_V

kubeadm join --token 123456.1234567890123456 \
             --discovery-token-unsafe-skip-ca-verification $m_node_ip:6443 \
             --cri-socket=unix:///run/containerd/containerd.sock