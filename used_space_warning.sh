#!/bin/bash

# any filesystem with used space above this % will trigger a warning
THRESHOLD=50

set -e

#                                                perc    mnt    dev
df -H | egrep -v '^Filesystem|tmpfs' | awk '{print $5 " " $6 " " $1}' | while read output ;
do
    perc=$(echo $output | awk '{print $1}' | cut -d'%' -f1)
    mnt=$(echo $output | awk '{print $2}')
    dev=$(echo $output | awk '{print $3}')
    if [ $perc -ge $THRESHOLD ] ; then
        echo "Warning: $mnt ($dev) used space is above threshold $THRESHOLD% (actual $perc%)"
    fi
done
