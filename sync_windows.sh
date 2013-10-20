#!/bin/bash

#/ Syncs various data directories to/from the Windows disk.

SRC_DIRS="/srv/videos /srv/installs /home/sam/Music"
WIN_VOL=/mnt/windows
WIN_DEST=$WIN_VOL/from-lemon/

mount | grep -q $WIN_VOL
if [ $? -eq 0 ] ; then
    echo "Windows volume $WIN_VOL is already mounted. Aborting." 1>&2
    exit 2
fi

grep -q $WIN_VOL /etc/fstab
if [ $? -ne 0 ] ; then
    echo "Windows volume $WIN_VOL does not exist in fstab. Aborting." 1>&2
    exit 2
fi

sudo mount $WIN_VOL || exit 3
echo "Syncing from Linux to Windows"
rsync -av --delete --exclude="lost+found" --exclude=".Trash-*" $SRC_DIRS $WIN_DEST
#echo
#echo "Syncing from Windows to Linux"
#rsync -av --no-g --no-p --exclude=".Thumbs.db" --exclude="Music" $WIN_DEST /srv
sudo umount $WIN_VOL
