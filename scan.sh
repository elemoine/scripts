#!/bin/bash

FILE=$1
shift

hp-scan --dest=file --mode=gray --size=a4 --resolution=100 --file=${FILE}.tmp $*
ps2pdf ${FILE}.tmp ${FILE}
rm ${FILE}.tmp
