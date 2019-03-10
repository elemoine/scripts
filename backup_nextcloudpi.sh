#!/bin/bash

set -e
set -x

DEV=/dev/sdb

LABEL=backup
MNTPT=/media/$LABEL

set +e
mount | grep "$DEV on $MNTPT" > /dev/null
mounted=$?
set -e

if [[ $mounted -ne 0 ]]; then
    pmount $DEV $LABEL
fi

rsync -e ssh -avz --rsync-path="sudo -u www-data rsync" nextcloudpi:/mnt/raid0/nextcloud/data/ $MNTPT/nextcloud/data/

pumount $DEV

exit 0
