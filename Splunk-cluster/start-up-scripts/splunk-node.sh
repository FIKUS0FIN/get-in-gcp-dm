#!/bin/bash

cd /opt/splunk

./bin/splunk edit cluster-config -mode master -replication_factor 4 -search_factor 3 -secret your_key -cluster_label cluster1  -auth admin:changeme
./bin/splunk restart 