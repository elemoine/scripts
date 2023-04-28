#!/bin/bash

device="wlan0"
ssid=$1

iwctl station $device scan
iwctl station $device get-networks

if [[ -n ${ssid} ]]; then
    iwctl station $device connect "${ssid}"
fi
