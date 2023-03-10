#!/usr/bin/env bash

# init kubernetes 
kubeadm init --token 123456.1234567890123456 --token-ttl 0 \
--pod-network-cidr=172.16.0.0/16 --apiserver-advertise-address=192.168.29.10

# config for master node only 
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

# raw_address for gitcontent
raw_git="raw.githubusercontent.com/yellowsunn/local-iac/master/manifest"
bin_path="/usr/local/bin"

# config for kubernetes's network 
kubectl apply -f https://$raw_git/172.16_net_calico_v3.25.0.yaml

# config metallb for LoadBalancer service
kubectl apply -f https://$raw_git/metallb-0.12.1.yaml

# create configmap for metallb (192.168.29.20 - 192.168.29.120)
kubectl apply -f https://$raw_git/metallb-l2config.yaml

# create secret for metallb 
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

# install helm
curl -0L https://get.helm.sh/helm-v3.11.0-linux-amd64.tar.gz > helm-v3.11.0-linux-amd64.tar.gz
tar xvfz helm-v3.11.0-linux-amd64.tar.gz
mv linux-amd64/helm $bin_path/.
rm -f helm-v3.11.0-linux-amd64.tar.gz
rm -rf linux-amd64/

# install bash-completion for kubectl 
yum install bash-completion -y 

# kubectl completion on bash-completion dir
kubectl completion bash >/etc/bash_completion.d/kubectl

# alias kubectl to k 
echo 'alias k=kubectl' >> ~/.bashrc
echo "alias ka='kubectl apply -f'" >> ~/.bashrc
echo 'complete -F __start_kubectl k' >> ~/.bashrc
