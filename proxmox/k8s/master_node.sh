#/user/bin/env bash

## configuration variables ##
# max number of worker nodes
N=0
# each of components to install 
k8s_V='1.28.1'           # Kubernetes 
ctrd_V='1.6.21-3.1.el7'   # Containerd 
docker_V='24.0.2-1.el7'     # Docker  

# master node ip
m_node_ip='192.168.0.151'
## /configuration variables ##

EXTERNAL_SCRIPTS='https://raw.githubusercontent.com/yellowsunn/local-iac/main/proxmox/k8s/scripts'

sh -c "$(curl -fsSL $EXTERNAL_SCRIPTS/k8s_env_build.sh)" $N $m_node_ip
sh -c "$(curl -fsSL $EXTERNAL_SCRIPTS/scripts/k8s_pkg_cfg.sh)" $k8s_V $docker_V $ctrd_V
sh -c "$(curl -fsSL $EXTERNAL_SCRIPTS/scripts/controlplane_node.sh)" $k8s_V $m_node_ip
sh -c "$(curl -fsSL $EXTERNAL_SCRIPTS/scripts/k8s_extra_pkgs.sh)"