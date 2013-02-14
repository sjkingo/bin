#!/bin/bash

# any filesystem with used space above this % will trigger a warning
THRESHOLD=50

#                                                perc    mnt    dev
df -H | egrep -v '^Filesystem|tmpfs' | awk '{print $5 " " $6 " " $1}' | while read output ;
do
    perc=$(echo $output | awk '{print $1}' | cut -d'%' -f1)
    mnt=$(echo $output | awk '{print $2}')
    dev=$(echo $output | awk '{print $3}')

    # skip if this is mounted read-only
    grep $mnt /proc/mounts | grep -q ' ro'
    [[ $? -eq 0 ]] && continue

    # check if above threshold
    if [ $perc -ge $THRESHOLD ] ; then
        echo "Warning: $mnt ($dev) used space is above threshold $THRESHOLD% (actual $perc%)"
    fi
done
