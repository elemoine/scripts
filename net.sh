#!/bin/bash

iface="wlp0s20f3"
wpa_network=$1

if [[ -n $wpa_network ]]; then
    sudo wpa_cli -i ${iface} select_network $wpa_network
fi

sudo wpa_cli -i ${iface} list_networks

exit 0
