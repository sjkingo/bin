#!/bin/bash

DEST="/srv/fedora-mirror/mirror"
RSYNC_MIRROR="rsync://mirror.aarnet.edu.au/fedora/linux"
EXCLUDE="$DEST/../EXCLUDE"

rsync -av -H --exclude-from=${EXCLUDE} --numeric-ids --delete --delete-after --delay-updates \
    ${RSYNC_MIRROR} ${DEST}
