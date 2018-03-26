# Deployment Manager Templates for Splunk Cluster

This repository contains Deployment Manager template for deploying Splunk Cluster.

![alt text](https://raw.githubusercontent.com/FIKUS0FIN/get-in-gcp-dm/master/splunk-cluster-group/Images/image_gif_.gif)
## Pre-requirements

1. Install Cloud SDK:

```bash
https://cloud.google.com/sdk/?hl=uk#Quick_Start
```

2. Set your project ID.

```bash
gcloud config set project [myproject]
```

3. Set your default zone and region

```bash
gcloud config set compute/region europe-west3
gcloud config set compute/zone europe-west3-b
```

4. Enable Deployment Manager:

```bash
https://console.cloud.google.com/start/api?id=deploymentmanager&hl=uk
```

5. Clone the repository 

6. Cretae deployments templates with gcloud

```bash
cd get-in-gcp-dm/splunk-cluster-group
gcloud deployment-manager deployments create splunk-cluster --config splunk-cluster-deploy.yaml
# for deleting use that comand 
gcloud deployment-manager deployments delete splunk-cluster
# each time when u got fail u have to delete deployments first or use different name 
```

# Deployment Manager Templates structure
![alt text](https://raw.githubusercontent.com/FIKUS0FIN/get-in-gcp-dm/master/splunk-cluster-group/Images/export.png)

```bash
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
```

## Networking 
Templates location network-configs folder 

    Consist of VPC SourceRange " 10.0.0.1/24 " 
    FireWalls rules for 10.0.0.1/24 and 0.0.0.0/0 SourceRanges
    Internal rules : 10.0.0.1/24 - TCP:[ 80,22,8000-9999] UDP:514 and icmp
    External rules : 0.0.0.0/0 - TCP:[22,80,443]
    
Down_reference external FireWall 80 and 443 will use only Bastion host 

## Compute 
Templates location vm-configs forlder 

```bash
Consist of templates ralated to InstanceGroup,InstanceAutoscaler,InstanceTemplete, Splunk-sh mashines,Base_Image,Bastion-proxy-pass...
```

Memo - very important referring to network in instance template because IT can be created befo network it will couse error.