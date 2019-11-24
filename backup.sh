#!/bin/bash

DEST=/mnt/samext

do_mount() {
    mount | grep -q $DEST
    if [ $? -ne 0 ] ; then
        sudo mount $DEST || exit 1
    fi
}

do_mount
sudo rsync -avx --delete --stats /home /etc /srv/bigdata /srv/installs /srv/videos /srv/virtualbox /var/lib/pgsql $DEST/Backup
df $DEST
sudo umount $DEST
