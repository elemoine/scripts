#!/bin/bash

# A wrapper script for ~/src/backup.sh

set -e

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

[[ -f $HOME/.restic_password_file ]] && RESTIC_PASSWORD_FILE="$HOME/.restic_password_file"

cd $HOME/src/backup
RESTIC_PASSWORD_FILE=$RESTIC_PASSWORD_FILE ./backup.sh -d $MNTPT/backup -v

if [[ $mounted -ne 0 ]]; then
    pumount $DEV
fi

exit 0
