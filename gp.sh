#!/bin/bash

pgrep -u elemoine PanGPA > /dev/null
if [[ $? -ne 0 ]]; then
    echo "Starting gpa..."
    /opt/paloaltonetworks/globalprotect/PanGPA start &
fi

action=$1

if [[ -z $action ]]; then
    globalprotect disconnect
    globalprotect connect -p gp.ultimatesoftware.com -u EricLe
else
    globalprotect $*
fi
