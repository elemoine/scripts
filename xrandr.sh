#!/bin/bash

#
# Usage examples:
# xrandr.sh
# xrandr.sh --off
# xrandr.sh DP-1-8
# xrandr.sh DP-1-8 --off
#

DEFAULT_OUTPUT="HDMI-1"
DEFAULT_ACTION="--right-of eDP-1 --primary --auto"

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
