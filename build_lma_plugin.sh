#!/bin/bash

#set -x

if [[ -z $PLUGINS ]]; then
    PLUGINS="fuel-plugin-lma-collector fuel-plugin-elasticsearch-kibana fuel-plugin-influxdb-grafana fuel-plugin-lma-infrastructure-alerting"
fi

function usage {
    echo "Usage: $0 [-b] [-c <branch>] [-t <tag>] [-f <fuel_master>]"
    echo ""
    echo "-b: build plugin packages"
    echo "-c: update plugins to <branch>"
    echo "-t: update plugins to <tag>"
    echo "-f: install plugins to <fuel_master>"
    echo ""
}

while getopts ":bc:t:f:" opt; do
    case $opt in
    b)
        build_packages=1
        ;;
    c)
        update_plugins=1
        branch=$OPTARG
        ;;
    t)
        update_plugins=1
        tag=$OPTARG
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
    if [[ -n $update_plugins ]]; then
        cd $plugin
        git fetch origin
        if [[ -n $branch ]]; then
            echo "Update $plugin ($branch)…"
            git rev-parse --verify $branch > /dev/null 2>&1 || git branch $branch origin/$branch
            git checkout $branch
            git merge --ff-only origin/$branch
            echo "Done."
            echo "Checking out $branch…"
            git checkout $branch
            echo "Done."
        elif [[ -n $tag ]]; then
            echo "Checking out $tag…"
            git checkout $tag
            echo "Done."
        fi
        cd ..
    fi
    if [[ -n $build_packages ]]; then
      cd $plugin
      echo "Build $plugin…"
      rm -f repositories/ubuntu/*
      rm -rf deployment_scripts/puppet/modules
      git checkout deployment_scripts/puppet/modules
      fpb --build .
      echo "Done."
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
