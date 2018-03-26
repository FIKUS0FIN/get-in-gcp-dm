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