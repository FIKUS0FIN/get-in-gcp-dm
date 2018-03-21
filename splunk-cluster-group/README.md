# Deployment Manager Templates for Splunk Cluster

This repository contains Deployment Manager template for deploying Splunk Cluster. By default, this will     deploy the following topology:

![alt text](https://raw.githubusercontent.com/FIKUS0FIN/get-in-gcp-dm/master/splunk-cluster-group/Images/export.png)


Splunk Cluster will have 4 preemptible peers in one Group,
One Splunk Search Head creades form privat Splunk image,
Teanpleate for splunk-peers group without Autoscaling 
