#!/bin/bash
apt update && apt upgrade -y && apt install -y htop 
DOWNLOAD_LINK
sudo dpkg -i splunk*.deb
cd /opt/splunk
sleep 60s
./bin/splunk start --accept-license
./bin/splunk enable boot-start 
./bin/splunk edit cluster-config -mode slave -master_uri https://MASTERNODE:8089 -replication_port 9887 -secret PASSWORD -auth admin:changeme
./bin/splunk restart 