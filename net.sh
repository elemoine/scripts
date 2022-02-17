#!/bin/bash

iface="wlp0s20f3"
wpa_network=${1:-0}

sudo wpa_cli -i ${iface} select_network ${wpa_network}
sudo wpa_cli -i ${iface} list_networks

exit 0
