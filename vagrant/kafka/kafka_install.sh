#!/usr/bin/env bash

# install java 1.8
apt-get update
apt-get install openjdk-8-jdk -y

# download kafka binary package
wget https://archive.apache.org/dist/kafka/3.3.1/kafka_2.13-3.3.1.tgz
tar -zxvf kafka_2.13-3.3.1.tgz
cd kafka_2.13-3.3.1

# override zookeepr.properties
wget https://raw.githubusercontent.com/yellowsunn/local-iac/main/vagrant/kafka/config/zookeeper.properties
mv config/zookeeper.properties config/zookeeper.properties.bak
mv zookeeper.properties config

# download server.porperties
wget https://raw.githubusercontent.com/yellowsunn/local-iac/main/vagrant/kafka/config/kafka-broker-$1.properties
mv config/server.properties config/server.properties.bak
mv kafka-broker-$1.properties config/server.properties

# set zookeeper id
mkdir /tmp/zookeeper
echo $1 > /tmp/zookeeper/myid

# run zookper and kafka server
bin/zookeeper-server-start.sh -daemon ./config/zookeeper.properties
bin/kafka-server-start.sh -daemon ./config/server.properties

# set systemctl
wget https://raw.githubusercontent.com/yellowsunn/local-iac/main/vagrant/kafka/config/zookeeper-server.service
wget https://raw.githubusercontent.com/yellowsunn/local-iac/main/vagrant/kafka/config/kafka-server.service

mkdir /usr/lib/systemd/system
mv zookeeper-server.service /usr/lib/systemd/system/zookeeper-server.service
mv kafka-server.service /usr/lib/systemd/system/system/kafka-server.service

systemctl daemon-reload
systemctl restart zookeeper-server.service
systemctl enable zookeeper-server.service
systemctl restart kafka-server.service
systemctl enable kafka-server.service
