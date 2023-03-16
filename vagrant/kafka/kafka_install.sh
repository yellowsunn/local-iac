#!/usr/bin/env bash

# install java 1.8
apt-get update
apt-get install openjdk-8-jdk -y

# set zookeeper id
echo $1 > myid
mkdir /tmp/zookeeper
cp myid /tmp/zookeeper/myid

# download kafka binary package
wget https://archive.apache.org/dist/kafka/3.3.1/kafka_2.13-3.3.1.tgz
tar -zxvf kafka_2.13-3.3.1.tgz
mv kafka_2.13-3.3.1 /opt/kafka

# override zookeepr.properties
wget https://raw.githubusercontent.com/yellowsunn/local-iac/main/vagrant/kafka/config/zookeeper.properties
mv /opt/kafka/config/zookeeper.properties /opt/kafka/config/zookeeper.properties.bak
mv zookeeper.properties /opt/kafka/config

# download server.porperties
wget https://raw.githubusercontent.com/yellowsunn/local-iac/main/vagrant/kafka/config/kafka-broker-$1.properties
mv /opt/kafka/config/server.properties /opt/kafka/config/server.properties.bak
mv kafka-broker-$1.properties /opt/kafka/config/server.properties

# download zookeeper, kafka service
mkdir -p /usr/lib/systemd/system
cd /usr/lib/systemd/system
wget https://raw.githubusercontent.com/yellowsunn/local-iac/main/vagrant/kafka/config/zookeeper.service
wget https://raw.githubusercontent.com/yellowsunn/local-iac/main/vagrant/kafka/config/kafka.service

# run zookper and kafka server
# bin/zookeeper-server-start.sh -daemon ./config/zookeeper.properties
# bin/kafka-server-start.sh -daemon ./config/server.properties

# reboot setting
systemctl daemon-reload
systemctl start zookeeper
systemctl enable zookeeper
systemctl start kafka
systemctl enable kafka