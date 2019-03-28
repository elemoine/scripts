#!/bin/bash

output=$1
[[ -n $output ]] || output="HDMI-2"

/usr/bin/xrandr --output $output --right-of eDP-1 --primary --auto
