#!/bin/bash

# mail_onboot.sh - sends an email to root with dmesg output
#   note make sure root's mail redirects somewhere useful in /etc/aliases

set -e

echo "To: root
From: root@`hostname`
Subject: `hostname` has booted

`hostname` has booted at `date`

dmesg output:
`dmesg`
" | sendmail -t
