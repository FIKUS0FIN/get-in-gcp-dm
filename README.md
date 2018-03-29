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
# each time when u got fail, delete deployments first or use different name 
```

# Deployment Manager Templates structure

```bash
.
├── README.md
├── network-configs
│   ├── firewall-template.jinja
│   └── network-template.jinja
├── splunk-cluster-deploy.yaml
├── start-up-scripts
│   ├── bastion.sh
│   ├── splunk-peer-temp.sh
│   └── splunk-sh.sh
└── vm-configs
    ├── autoscaled_group.jinja
    ├── autoscaler.jinja
    ├── compute-engine-template.jinja
    ├── password.py
    ├── service_account.jinja
    ├── splunk-template.jinja
    ├── vm-splunk-bastion.jinja
    └── vm-splunk-sh.jinja
```