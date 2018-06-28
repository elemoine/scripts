#!/bin/bash

# A wrapper script for ~/src/backup.sh

set -e

DEV=/dev/sdb
MNTPT=/media/usb0

set +e
mount | grep "$DEV on $MNTPT" > /dev/null
mounted=$?
set -e

if [[ $mounted -ne 0 ]]; then
    sudo mount $DEV $MNTPT
fi

cd $HOME/src/backup
./backup.sh -d $MNTPT/backup -v

sudo umount $DEV

exit 0
