#!/bin/bash
set -x
set -e
set -o pipefail
[ -f tox.ini ] && tox
exit 0
