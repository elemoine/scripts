#!/bin/bash

set -e
set -x

DEVNAME=sdb
DEV=/dev/$DEVNAME
MNTPT=/media/$DEVNAME

set +e
mount | grep "$DEV on $MNTPT" > /dev/null
mounted=$?
set -e

if [[ $mounted -ne 0 ]]; then
    pmount $DEV
fi

rsync -e ssh -avz --rsync-path="sudo -u www-data rsync" nextcloudpi:/mnt/raid0/nextcloud/data/ $MNTPT/nextcloud/data/

if [[ $mounted -ne 0 ]]; then
    pumount $DEV
fi

exit 0
