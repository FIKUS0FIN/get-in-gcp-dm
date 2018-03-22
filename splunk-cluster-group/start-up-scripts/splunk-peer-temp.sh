#!/bin/bash
apt update && apt upgrade -y && apt install -y htop
CLUSTER_PASS=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/tags" -H "Metadata-Flavor: Google" | cut -d '"' -f 2) 
MASTER_NODE=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/tags" -H "Metadata-Flavor: Google" | cut -d '"' -f 4)
wget -O splunk-7.0.2-03bbabbd5c0f-linux-2.6-amd64.deb 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.0.2&product=splunk&filename=splunk-7.0.2-03bbabbd5c0f-linux-2.6-amd64.deb&wget=true'
sudo dpkg -i splunk*.deb
cd /opt/splunk
./bin/splunk start --accept-license
./bin/splunk enable boot-start
./bin/splunk edit cluster-config -mode slave -master_uri https://$MASTER_NODE:8089 -replication_port 9887 -secret $CLUSTER_PASS -auth admin:changeme
./bin/splunk restart 