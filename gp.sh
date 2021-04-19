#!/bin/bash

pgrep -u elemoine PanGPA > /dev/null
if [[ $? -ne 0 ]]; then
    echo "Starting gpa..."
    /opt/paloaltonetworks/globalprotect/PanGPA start &
fi

action=$1

if [[ -z $action ]]; then
    globalprotect disconnect
    globalprotect connect -p fl-gp.ultimatesoftware.com -u EricLe
elif [[ $action == "d" ]]; then
    globalprotect disconnect
else
    globalprotect $*
fi
