#!/bin/bash

set -x

sudo ip link set wlp2s0 up
sudo iw dev wlp2s0 scan | grep 'SSID\:'
sudo ip link set wlp2s0 down
