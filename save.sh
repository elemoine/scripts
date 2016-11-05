#!/bin/bash

# https://help.ubuntu.com/community/Mount/USB
# sudo mount -t vfat /dev/sdb1 /mnt -o uid=1000,gid=1000,utf8,dmask=027,fmask=137

FILE=$1
DESTDIR=$2

if [[ ! -f ${FILE} ]]; then
    echo "Erreur : ${FILE} n'existe pas"
    exit 1
fi

if [[ ! -d ${DESTDIR} ]]; then
    echo "Erreur: ${DESTDIR} n'existe pas"
    exit 1
fi

if ! mount | grep -q ${DESTDIR}; then
    echo "Erreur: ${DESTDIR} n'est pas un point de montage"
    exit 1
fi


while true; do
    printf "[$(date)] Copie fichier..."
    cp ${FILE} ${DESTDIR}
    printf " OK.\n"
    sleep 20
done
