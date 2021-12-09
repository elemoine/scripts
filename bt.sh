#!/usr/bin/env bash

MACADDR="78:2B:64:15:9F:8A"

echo -e "pair $MACADDR\nconnect $MACADDR\n" | bluetoothctl
