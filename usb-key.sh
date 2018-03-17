#!/bin/bash

action=$1

usage() {
    echo "$0 [-o|-c]"
    exit 1
}

[[ -n $action ]] || usage

if [[ $action == "-c" ]]
then
    sudo umount /media/usb0
    sudo cryptsetup luksClose usbkey1
else
    sudo cryptsetup luksOpen /dev/sdc1 usbkey1
    sudo mount /dev/mapper/usbkey1 /media/usb
fi

exit 0
