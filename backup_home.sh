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

[[ -f $HOME/.restic_password_file ]] && RESTIC_PASSWORD_FILE="$HOME/.restic_password_file"

cd $HOME/src/backup
RESTIC_PASSWORD_FILE=$RESTIC_PASSWORD_FILE ./backup.sh -d $MNTPT/backup -v

sudo umount $DEV

exit 0
