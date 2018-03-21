# Deployment Manager Templates for Splunk Cluster

This repository contains Deployment Manager template for deploying Splunk Cluster. By default, this will     deploy the following topology:

![alt text](https://raw.githubusercontent.com/FIKUS0FIN/get-in-gcp-dm/master/splunk-cluster-group/Images/export.png)


# Deployment Manager Templates structure
.
├── README.md
├── splunk-cluster-deploy.yaml
├── network-configs
│   ├── firewall-template.jinja
│   └── network-template.jinja
└── vm-configs
    ├── compute-engine-template.jinja
    ├── splunk-templeate.jinja
    ├── vm-splunk-bastion.jinja
    └── vm-splunk-sh.jinja

## splunk-cluster-deploy.yaml
Main config file for Template creation 
Contain:
  - paths to jinja Templates
  - path resources file whtere deffine infrastructure 

## compute-engine-template.jinja
Templeate file where we declaring the:

 - environment variables
 - resources names 
 - resources properties
 - types *in our case path to jinja templeta*
 
Contained hardcoded resources of instanceGroupManager with 

 - name 
 - baseInstanceName
 - instanceTemplate refer to $(ref.splunk-peer-it.selfLink)
 - targetSize 
 - zone


## Networking 
### network-template.jinja and irewall-template.jinja
Template file for network and firewall rules creation 

- reffer to compute-engine Template *{{ env["name"] }}* 

### Vm-configs folder
Containe the most important template's deffining whith resources will be created 
#### splunk-templeate.jinja
reffer to compute-engine Template with parameters of 

- {{ env["name"] }}
- {{ properties["machineType"] }}
- sourceImage Image 
- reffer to network selfLink  $(ref.{{ properties["network"] }}.selfLink)
MEMO - very important reffering to network in instance templete becouse IT can be created befo network 
it will couse error

#### vm-splunk-sh.jinja
Splunk Search Head Template containes:

- reffer to compute-engine Template *{{ env["name"] }}* 
- reffer of  {{ properties["zone"] }}
- reffer of {{ properties["machineType"] }}
- reffer network $(ref.{{ properties["network"] }}.selfLink)

#### vm-splunk-bastion.jinja 
Only one host with can communicate with Expernal network: 
 - Start_up script with installing Nginx-proxy 
 - Tags : http-server
 - dependsOn : splunk-sh and 
 - reffer network $(ref.{{ properties["network"] }}.selfLink)
 - reffer of  {{ properties["zone"] }}
 - reffer of {{ properties["machineType"] }}

Splunk Cluster will have 4 preemptible peers in one Group,
One Splunk Search Head creates form privat Splunk image,
Teanpleate for splunk-peers group without Autoscaling 

### Privat image start_up script 
From public Ubuntu 16.04 LTS
```
#!/bin/bash
apt update && apt upgrade -y && apt install -y htop
wget -O splunk-7.0.2-03bbabbd5c0f-linux-2.6-amd64.deb 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.0.2&product=splunk&filename=splunk-7.0.2-03bbabbd5c0f-linux-2.6-amd64.deb&wget=true'
sudo dpkg -i splunk*.deb
cd /opt/splunk
./bin/splunk start --accept-license
./bin/splunk enable boot-start
./bin/splunk edit cluster-config -mode master -replication_factor 4 -search_factor 3 -secret your_key -cluster_label cluster1  -auth admin:changeme
./bin/splunk restart 
```
