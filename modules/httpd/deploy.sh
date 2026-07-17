#!/usr/bin/env bash

# set

HOST=gettransfer.lt
PASS=TcpLQPhXB3MBPAbZvtRn
USER=gettransf
FTPURL="ftp://$USER:$PASS@$HOST"
LCD=/etc/nixos/httpd
RCD=/domains/gettransfer.lt/public_html

DELETE="--delete"

lftp -c "set ftp:list-options -a;
set cmd:fail-exit yes;
set ssl:verify-certificate true;
open '$FTPURL';
lcd $LCD;
cd $RCD;
mirror --reverse \
$DELETE \
--verbose \
--exclude-glob .git/ \
--exclude-glob vendor/ \
--exclude-glob __pycache__/ \
"
