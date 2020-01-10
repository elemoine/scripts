#!/bin/bash

DEFAULT_OUTPUT="HDMI-1"
DEFAULT_ACTION="--right-of eDP-1 --primary --auto"

if [[ -n $1 ]]; then
    if [[ $1 == "--off" ]]; then
        action=$1
        output=$DEFAULT_OUTPUT
    else
        action=$DEFAULT_ACTION
        output=$1
    fi
else
    action=$DEFAULT_ACTION
    output=$DEFAULT_OUTPUT
fi

/usr/bin/xrandr --output $output $action
