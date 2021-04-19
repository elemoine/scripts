#!/bin/bash

set -eux

FILEPATH=$1
shift

FILEPATH_NO_EXTENSION=${FILEPATH%.*}
EXTENSION=${FILEPATH##*.}

TEMP_FILEPATH=${FILEPATH_NO_EXTENSION}-tmp.${EXTENSION}

cmd="hp-scan --dest=file --mode=gray --size=a4 --resolution=100 --file=${TEMP_FILEPATH} $*"
echo $cmd
$cmd
ps2pdf ${TEMP_FILEPATH} ${FILEPATH}
rm ${TEMP_FILEPATH}
