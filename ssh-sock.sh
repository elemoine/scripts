#!/bin/bash

set -x

if [[ -n $1 ]]
then
    server=$1
else
    server="lab"
fi

ssh -N -D 9999 $server
