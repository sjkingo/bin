#!/bin/bash

RES="2560x1390"

if [ $# -lt 1 ] || [ $# -gt 3 ]; then
    echo "Usage: $0 [-p] host [user] [domain]"
    exit 1
fi

function profile {
    if [ "$1" = "ps" ] ; then
        HOST="ps.wfsltd.com.au"
        USER="Administrator"
        DOMAIN="WFSLTD"
        CONSOLE="yes"
    elif [ "$1" = "ws" ] ; then
        HOST="ws.wfsltd.com.au"
        USER="Administrator"
        DOMAIN="WS"
        CONSOLE="yes"
    elif [ "$1" = "carmed" ] ; then
        HOST="carsel1.lnk.telstra.net"
        USER="Administrator"
        DOMAIN="MEDICAL"
        CONSOLE="yes"
    elif [ "$1" = "dpharm" ] ; then
        HOST="apharm.lnk.telstra.net"
        USER="skingston"
        DOMAIN="MINFOS.LOCAL"
        CONSOLE="no"
    elif [ "$1" = "prime" ] ; then
        HOST="aph1483135.lnk.telstra.net"
        USER="skingston"
        DOMAIN="PRIMECO"
        CONSOLE="yes"
    else
        echo "$0: profile '$1' unknown, using as hostname instead"
        HOST="$1"
        CONSOLE="no"
    fi
}

# If `-p host` was given, this is a profile so call profile() to populate.
# Otherwise extract as per usage
if [ "$1" = "-p" ] ; then
    if [ $# -lt 2 ] ; then
        echo "$0: -p requires an argument"
        exit 1
    fi
    profile $2
else 
    HOST="$1"
    USER="$2"
    DOMAIN="$3"
fi

# Format the arguments properly
if [ "$USER" != "" ] ; then
    USER=" -u $USER "
fi
if [ "$DOMAIN" != "" ] ; then
    DOMAIN="-d $DOMAIN "
fi

# if $CONSOLE is set and its value equals "no", then connect as a session,
# otherwise connect to the console
if [ "$CONSOLE" != "no" ] ; then
    CONSOLE="-0"
else
    CONSOLE=""
fi

rdesktop $USER $DOMAIN -g $RES -N -z -P $CONSOLE $HOST 
