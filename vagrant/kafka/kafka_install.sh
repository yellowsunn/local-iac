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
cd kafka_2.13-3.3.1

# override zookeepr.properties
wget https://raw.githubusercontent.com/yellowsunn/local-iac/main/vagrant/kafka/config/zookeeper.properties
mv config/zookeeper.properties config/zookeeper.properties.bak
mv zookeeper.properties config

# download server.porperties
wget https://raw.githubusercontent.com/yellowsunn/local-iac/main/vagrant/kafka/config/kafka-broker-$1.properties
mv config/server.properties config/server.properties.bak
mv kafka-broker-$1.properties config/server.properties

# run zookper and kafka server
bin/zookeeper-server-start.sh -daemon ./config/zookeeper.properties
bin/kafka-server-start.sh -daemon ./config/server.properties

# reboot setting
echo "sudo mkdir /tmp/zookeeper" >> /home/vagrant/.profile
echo "sudo cp /home/vagrant/myid /tmp/zookeeper/myid" >> /home/vagrant/.profile
echo "sudo /home/vagrant/kafka_2.13-3.3.1/bin/zookeeper-server-start.sh -daemon /home/vagrant/kafka_2.13-3.3.1/config/zookeeper.properties" >> /home/vagrant/.profile
echo "sudo /home/vagrant/kafka_2.13-3.3.1/bin/kafka-server-start.sh -daemon /home/vagrant/kafka_2.13-3.3.1/config/server.properties" >> /home/vagrant/.profile
