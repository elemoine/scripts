#!/bin/bash

set -e
set -x

DEV_SRC=/dev/sdd1
MNT_SRC=/media/sdd1

UUID=4a77269b-b7c7-4da4-81b3-ca5d218fe59a
DEV_DST=/dev/disk/by-uuid/$UUID
MNT_DST=/media/disk_by-uuid_$UUID

set +e
mount | grep "on $MNT_SRC" > /dev/null
src_mounted=$?
set -e

if [[ $src_mounted -ne 0 ]]; then
    sudo mount 
    pmount $DEV_SRC
fi

#rsync -e ssh -av -zz --rsync-path="sudo -u www-data rsync" nextcloudpi:/mnt/raid0/nextcloud/data/ $MNTPT/nextcloud/data/

if [[ $src_mounted -ne 0 ]]; then
    pumount $DEV_SRC
fi

exit 0
