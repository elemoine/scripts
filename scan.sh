#!/bin/bash

FILE=$1

hp-scan --dest=file --mode=gray --size=a4 --resolution=100 --file=${FILE}
