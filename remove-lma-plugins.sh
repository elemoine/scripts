#!/bin/bash

if [[ -z $VERSION ]]; then
    VERSION=0.9.0
fi

if [[ -z $PLUGINS ]]; then
    PLUGINS="lma_collector elasticsearch_kibana influxdb_grafana lma_infrastructure_alerting"
fi

function usage {
    echo "Usage: $0 [-f <fuel_master>]"
    echo ""
}

while getopts "f:" opt; do
    case $opt in
    f)
        fuel_master=$OPTARG
        ;;
    \?)
        echo "Invalid option: -$OPTARG" >&2
        usage $0
        exit 1
        ;;
    esac
done

if [[ -z $fuel_master ]]; then
    usage $0
    exit 1
fi

for plugin in $PLUGINS; do
    ssh root@${fuel_master} fuel plugins --remove ${plugin}==${VERSION}
done
