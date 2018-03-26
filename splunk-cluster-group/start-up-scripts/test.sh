#!/bin/bash
apt update && apt upgrade -y  && apt install nginx -y && apt install -y htop 
wget "https://github.com/FIKUS0FIN/get-in-gcp-dm/blob/master/splunk-cluster-group/vm-configs/compute-engine-template.jinja"
