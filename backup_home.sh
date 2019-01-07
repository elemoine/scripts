#!/bin/bash

# A wrapper script for ~/src/backup.sh

set -e

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

[[ -f $HOME/.restic_password_file ]] && RESTIC_PASSWORD_FILE="$HOME/.restic_password_file"

cd $HOME/src/backup
RESTIC_PASSWORD_FILE=$RESTIC_PASSWORD_FILE ./backup.sh -d $MNTPT/backup -v

pumount $DEV

exit 0
