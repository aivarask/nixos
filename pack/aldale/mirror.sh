#!/usr/bin/env bash
HOST=gettransfer.lt
PASS=TcpLQPhXB3MBPAbZvtRn
USER=gettransf
FTPURL="ftp://$USER:$PASS@$HOST"
LCD=/etc/nixos/_php/aldale
RCD=/domains/aldale.gettransfer.lt/public_html

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
--exclude-glob vendor/
"
