#!/bin/bash
apt update && apt upgrade -y && apt install -y htop
sudo dpkg -i splunk.deb
cd /opt/splunk
./bin/splunk start --accept-license
./bin/splunk enable boot-start
./bin/splunk edit cluster-config -mode master -replication_factor 4 -search_factor 3 -secret {{ properties["password"] }} -cluster_label cluster1  -auth admin:changeme
./bin/splunk enable listen 9997 -auth admin:changeme
./bin/splunk restart