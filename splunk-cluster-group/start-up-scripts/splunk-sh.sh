#!/bin/bash
apt update && apt upgrade -y && apt install -y htop
DOWNLOAD_LINK
dpkg -i sp*.deb
cd /opt/splunk
./bin/splunk start --accept-license
./bin/splunk enable boot-start
./bin/splunk edit cluster-config -mode master -replication_factor 4 -search_factor 3 -secret PASSWORD -cluster_label cluster1  -auth admin:changeme
./bin/splunk enable listen 9997 -auth admin:changeme
./bin/splunk restart