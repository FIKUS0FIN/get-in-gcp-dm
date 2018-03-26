#!/bin/bash
apt update && apt upgrade -y  && apt install nginx -y && apt install -y htop 
echo 'upstream backend {
        server 'MASTERNODE':8000;
}
server {
    listen 80;
    server_name  ~^.*$;
    location / {
        proxy_pass http://'MASTERNODE':8000;
    }
}'> /etc/nginx/conf.d/proxy.conf
sleep 20s
systemctl restart nginx 
wget -O splunkforwarder-7.0.2-03bbabbd5c0f-linux-2.6-amd64.deb 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.0.2&product=universalforwarder&filename=splunkforwarder-7.0.2-03bbabbd5c0f-linux-2.6-amd64.deb&wget=true'
dpkg -i sp*.deb
cd /opt/splunkforwarder
./bin/splunk start --accept-license
./bin/splunk enable boot-start