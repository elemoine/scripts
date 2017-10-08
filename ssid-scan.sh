#!/bin/bash

set -x

sudo ip link set wlp4s0 up
sudo iw dev wlp4s0 scan | grep 'SSID\:'
sudo ip link set wlp4s0 down
