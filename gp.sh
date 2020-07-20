#!/bin/bash

if [[ $1 = "-d" ]]; then
    globalprotect disconnect
else
    globalprotect connect -p gp.ultimatesoftware.com -u EricLe
fi
