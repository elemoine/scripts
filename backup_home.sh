#!/bin/bash

# A wrapper script for ~/src/backup.sh

set -e

UUID=037c0226-5719-4d60-9f13-c601e7162003
DEV=/dev/disk/by-uuid/$UUID
MNTPT=/media/disk_by-uuid_$UUID

set +e
mount | grep "on $MNTPT" > /dev/null
mounted=$?
set -e

function mount_disk()
{
    echo "Mounting $DEV..."
    pmount $DEV
}

function umount_disk()
{
    echo "Umounting $DEV..."
    pumount $DEV
}

if [[ $mounted -ne 0 ]]; then
    mount_disk
else
    echo "$DEV already mounted"
fi

trap umount_disk EXIT

[[ -f $HOME/.restic_password_file ]] && RESTIC_PASSWORD_FILE="$HOME/.restic_password_file"

cd $HOME/src/backup
RESTIC_PASSWORD_FILE=$RESTIC_PASSWORD_FILE ./backup.sh -d $MNTPT/backup_home_alma -v

exit 0
