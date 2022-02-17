#!/bin/bash

#
# Usage examples:
# xrandr.sh
# xrandr.sh --off
# xrandr.sh DP-1-8
# xrandr.sh DP-1-8 --off
#

LAPTOP_OUTPUT="eDP-1"
DEFAULT_OUTPUT="HDMI-1"
DEFAULT_ACTION="--right-of ${LAPTOP_OUTPUT} --primary --auto"

if [[ -n $1 ]]; then
    if [[ $1 == "--off" ]]; then
        action=$1
        output=$DEFAULT_OUTPUT
    else
        output=$1
        action=$DEFAULT_ACTION
        if [[ $2 == "--off" ]]; then
            action=$2
        fi
    fi
else
    action=$DEFAULT_ACTION
    output=$DEFAULT_OUTPUT
fi

/usr/bin/xrandr --output $output $action
[[ action == "-off" ]] && /usr/bin/xrandr --output ${LAPTOP_OUTPUT} --primary
