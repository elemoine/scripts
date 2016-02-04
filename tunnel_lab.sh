#!/bin/bash

set -x

# Fuel UI, Grafana, Kibana, Elasticsearch, Nagios
ssh -N -L 10000:10.109.0.2:8443 -L 10001:10.109.1.4:8000 -L 10002:10.109.1.5:80 -L 9200:10.109.1.5:9200 -L 10003:10.109.1.6:8001 lab 
