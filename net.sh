#!/bin/bash

action=$1
wpa_network=$2

ethe="enp0s31f6"
wifi="wlp2s0"

if [[ $action == "-w" ]]; then
    if [[ $(cat /sys/class/net/$wifi/operstate) == "down" ]]; then
        sudo systemctl stop dhcpcd@${ethe}
        sudo ip link set ${ethe} down
        sudo systemctl start wpa_supplicant@${wifi}
        sudo systemctl start dhcpcd@${wifi}
        sleep 4
    fi
    if [[ -z $wpa_network ]]; then
        sudo wpa_cli -i ${wifi} list_networks
    else
        sudo wpa_cli -i ${wifi} select_network $wpa_network
    fi
else
    if [[ $(cat /sys/class/net/$ethe/operstate) == "down" ]]; then
        sudo systemctl stop dhcpcd@${wifi}
        sudo systemctl stop wpa_supplicant@${wifi}
        sudo systemctl start dhcpcd@${ethe}
    fi
fi

exit 0
