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

. $HOME/.local/bin/virtualenvwrapper.sh

set +e
workon duplicity
set -e

cd $HOME/src/backup
./backup.sh -d $MNTPT/backup -s 5BBF59DF126FADEF -e 57F334375840CA38 -v

deactivate

sudo umount $DEV

exit 0
