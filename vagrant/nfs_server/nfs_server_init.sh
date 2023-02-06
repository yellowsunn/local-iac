#!/usr/bin/env bash

apt-get update
apt install nfs-kernel-server -y

if [[ ! -d /nfsdir ]]; then
    mkdir /nfsdir
fi

echo "/nfsdir   192.168.29.0/24(rw,sync,no_root_squash)" >> /etc/exports 
if [[ $(systemctl is-enabled nfs-kernel-server) -eq "disabled" ]]; then
    systemctl enable nfs-kernel-server
fi
systemctl restart nfs-kernel-server