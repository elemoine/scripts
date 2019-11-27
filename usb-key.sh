#!/bin/bash

action=$1
dev=$2

usage() {
    echo "$0 -o|-c [dev]"
    exit 1
}

[[ $action == "-o" ]] && [[ -n $dev ]] || [[ $action == "-c" ]] || usage

if [[ $action == "-c" ]]
then
    sudo umount /media/usb
    sudo cryptsetup luksClose usbkey1
else
    sudo cryptsetup luksOpen $dev usbkey1
    sudo mount /dev/mapper/usbkey1 /media/usb
fi

exit 0
