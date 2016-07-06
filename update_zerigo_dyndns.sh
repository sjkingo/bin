#!/bin/bash

HOST="home.sjkwi.com.au"
USER="sam@sjkwi.com.au"
PASS="7218435cbbeb5287fc4d3c00ce9baf38"

resp=$(wget -q "http://update.zerigo.com/dynamic?host=$HOST&user=$USER&password=$PASS" -O-)
echo "`date -Iseconds` $0 $resp" > ~/.dyndns_status
if [ "$resp" = "OK" ] || [ "$resp" = "Nothing to change" ] ; then
    exit 0
else
    echo "$resp"
    exit 1
fi
