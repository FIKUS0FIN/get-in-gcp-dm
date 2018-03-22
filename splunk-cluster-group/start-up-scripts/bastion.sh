#!/bin/bash
apt update && apt upgrade -y  && apt install nginx -y && apt install -y htop 
CLUSTER_PASS=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/tags" -H "Metadata-Flavor: Google" | cut -d '"' -f 2) 
MASTER_NODE=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/tags" -H "Metadata-Flavor: Google" | cut -d '"' -f 4)
echo 'upstream backend {
        server splunk-sh:8000;
}
server {
    listen 80;
    server_name  ~^.*$;
    location / {
        proxy_pass http://splunk-sh:8000;
    }
}'> /etc/nginx/conf.d/proxy.conf
systemctl restart nginx 
wget -O splunkforwarder-7.0.2-03bbabbd5c0f-linux-2.6-amd64.deb 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.0.2&product=universalforwarder&filename=splunkforwarder-7.0.2-03bbabbd5c0f-linux-2.6-amd64.deb&wget=true'
dpkg -i sp*.deb
cd /opt/splunkforwarder
./bin/splunk start --accept-license
./bin/splunk enable boot-start