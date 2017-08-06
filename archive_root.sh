#!/bin/bash

set -e

DEV_SRC=/dev/sda1
DEV_DEST=/dev/sdb

sudo mount $DEV_DEST /media/usb

sudo fsarchiver savefs -v -c - -z 1 -j 4 -A /media/usb/x1-oslandia-root-$(date +%F).fsa $DEV_SRC

sudo umount $DEV_DEST

exit 0
