#!/bin/bash

network=$1

wifi="wlp2s0"

if [[ -z $network ]]; then
    sudo wpa_cli -i ${wifi} list_networks
else
    sudo wpa_cli -i ${wifi} select_network $network
fi

exit 0
