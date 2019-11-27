#!/bin/bash

FILEPATH=$1
shift

FILEPATH_NO_EXTENSION=${FILEPATH%.*}
EXTENSION=${FILEPATH##*.}

TEMP_FILEPATH=${FILEPATH_NO_EXTENSION}-tmp.${EXTENSION}

hp-scan --dest=file --mode=gray --size=a4 --resolution=100 --file=${TEMP_FILEPATH} $*
ps2pdf ${TEMP_FILEPATH} ${FILEPATH}
rm ${TEMP_FILEPATH}
