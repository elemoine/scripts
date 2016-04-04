#!/bin/bash

set -x

#ssh -t -v -L 9999:localhost:9932 lab ssh -t -D 9932 root@10.109.0.2

ssh -N -D 9999 lab
