#!/bin/bash
set -e
rsync -av --delete sam@pharmacyhire-rsync:/var/www/html/wp-content/updraft "/home/sam/Dropbox/Backups/Website backups/pharmacyhire"
