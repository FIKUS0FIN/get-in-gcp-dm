#!/bin/bash
apt update && apt upgrade -y && apt install -y htop
wget -O splunk-7.0.2-03bbabbd5c0f-linux-2.6-amd64.deb "https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.0.2&product=splunk&filename=splunk-7.0.2-03bbabbd5c0f-linux-2.6-amd64.deb&wget=true"
dpkg -i sp*.deb
cd /opt/splunk
./bin/splunk start --accept-license
./bin/splunk enable boot-start
./bin/splunk edit cluster-config -mode master -replication_factor 4 -search_factor 3 -secret {{ properties["password"] }} -cluster_label cluster1  -auth admin:changeme
./bin/splunk enable listen 9997 -auth admin:changeme
./bin/splunk restart