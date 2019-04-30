#!/bin/bash

set -e
set -x

UUID=4a77269b-b7c7-4da4-81b3-ca5d218fe59a
DEV=/dev/disk/by-uuid/$UUID
MNTPT=/media/disk_by-uuid_$UUID

set +e
mount | grep "on $MNTPT" > /dev/null
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
