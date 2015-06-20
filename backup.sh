#!/bin/bash
set -x
duplicity --exclude-globbing-filelist /home/sam/.duplicity.filelist --encrypt-key 482EFAF8 -v8 $* / dpbx:///berry_backups
