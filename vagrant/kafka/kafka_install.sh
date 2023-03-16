#!/usr/bin/env bash

# install java 1.8
apt-get update
apt-get install openjdk-8-jdk -y

# download kafka binary package
wget https://archive.apache.org/dist/kafka/3.3.1/kafka_2.13-3.3.1.tgz
tar -zxvf kafka_2.13-3.3.1.tgz
cd kafka_2.13-3.3.1
