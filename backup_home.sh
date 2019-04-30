#!/bin/bash

# A wrapper script for ~/src/backup.sh

set -e

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

[[ -f $HOME/.restic_password_file ]] && RESTIC_PASSWORD_FILE="$HOME/.restic_password_file"

cd $HOME/src/backup
RESTIC_PASSWORD_FILE=$RESTIC_PASSWORD_FILE ./backup.sh -d $MNTPT/backup -v

if [[ $mounted -ne 0 ]]; then
    pumount $DEV
fi

exit 0
