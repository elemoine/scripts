#!/bin/bash

#set -x

if [[ -z $PLUGINS ]]; then
    PLUGINS="fuel-plugin-lma-collector fuel-plugin-elasticsearch-kibana fuel-plugin-influxdb-grafana fuel-plugin-lma-infrastructure-alerting"
fi

function usage {
    echo "Usage: $0 [-b] [-u] [-f <fuel_master>]"
    echo ""
    echo "-b: build plugin packages"
    echo "-u: update plugins master branches"
    echo "-f: install plugins to <fuel_master>"
    echo ""
}

while getopts ":buf:" opt; do
    case $opt in
    b)
        build_packages=1
        ;;
    u)
        update_master=1
        ;;
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

if [[ -n $build_packages ]]; then
    which fpb > /dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        echo "Error: fpb is not on your path"
        exit 1
    fi
fi

if [[ -n $fuel_master ]]; then
    ssh-copy-id root@$fuel_master
fi

for plugin in $PLUGINS; do
    if [[ -n $build_packages ]]; then
      cd $plugin
      if [[ -n $update_master ]]; then
          git checkout master
          git fetch origin
          git merge --ff-only origin/master
      fi
      fpb --build .
      cd ..
    fi
    if [[ -n $fuel_master ]]; then
        rpm=$(ls $plugin/*.rpm)
        if [[ $? -ne 0 ]]; then
            echo "Error: no rpm available in $plugin"
            exit 1
        fi
        scp $rpm root@$fuel_master:
        ssh root@$fuel_master fuel plugins --install $(basename $rpm)
    fi
done
