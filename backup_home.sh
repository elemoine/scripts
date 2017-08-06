#!/bin/bash

# A wrapper script for ~/src/backup.sh

set -e

DEV=/dev/sdb

sudo mount $DEV /media/usb

. $HOME/.local/bin/virtualenvwrapper.sh

set +e
workon duplicity
set -e

cd $HOME/src/backup
./backup.sh -d /media/usb/backup -s 5BBF59DF126FADEF -e 57F334375840CA38 -v

deactivate

sudo umount $DEV

exit 0
