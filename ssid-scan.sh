#!/bin/bash

set -x

iface="wlp0s20f3"

sudo ip link set $iface up
sudo iw dev $iface scan | grep 'SSID\:'
sudo ip link set $iface down
