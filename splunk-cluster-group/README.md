# Deployment Manager Templates for Splunk Cluster

This repository contains Deployment Manager template for deploying Splunk Cluster.

## Pre-requirements 
1. install Cloud SDK: https://cloud.google.com/sdk/?hl=uk#Quick_Start 
2. Set your project ID. 
```
gcloud config set project [myproject]
```
3. Set your default zone and region
```
gcloud config set compute/region europe-west3
gcloud config set compute/zone europe-west3-b
```
4. Enable Deployment Manager: https://console.cloud.google.com/start/api?id=deploymentmanager&hl=uk
5. Create instance splunk-sh with 40 GB on board and start_up script Feel free with other parameters 
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
5.1 Enable deletion protection : YES 
5.2 Wait until start_up script finish his job 
6. Kill the splunk-sh box 
7. Create image form splunk-sh disk 
7.1 Image name : splunk-sh 
7.2 Source disk : splunk-sh 
7.3 Feel free to add description and family
8. clone the repository 
9. Cretae deployments templates with gcloud 
```
cd step-by-step-dm/splunk-cluster-group
gcloud deployment-manager deployments create splunk-cluster --config splunk-cluster-deploy.yaml
# for deleting use that comand 
gcloud deployment-manager deployments delete splunk-cluster
# each time when u got fail u have to delete deployments first or use different name 
```

# Deployment Manager Templates structure
![alt text](https://raw.githubusercontent.com/FIKUS0FIN/get-in-gcp-dm/master/splunk-cluster-group/Images/export.png)

"
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
"
## Networking 
Templates location network-configs folder 
Consist of VPC SourceRange " 10.0.0.1/24 " 
FireWalls rules for 10.0.0.1/24 and 0.0.0.0/0 SourceRanges
Internal rules : 10.0.0.1/24 - TCP:[ 80,22,8000-9999] UDP:514 and icmp
External rules : 0.0.0.0/0 - TCP:[22,80,443]
Down_reference external FireWall 80 and 443 will use only Bastion host 

## Compute 
Templates location vm-configs forlder 
Consist templates ralated to InstanceGroup, InstanceTemplete and stand-alone mashines splunk-sh and Bastion
in compute-engine-template.jinja file u can:
change base configuration [names, properties],env variebles.
InstanceTemplete it's refer for unmanaged InstanceGroup with TargetSize: 4
Memo compute-engine-template containe hardcoded resource [ instanceGroupManager ].
Memo_2 - very important reffering to network in instance templete becouse IT can be created befo network it will couse error.