#!/usr/bin/env bash    

# https://gettransfer.lt:2222/CMD_FILE_MANAGER
# https://gettransfer.lt
HOST="gettransfer.lt"
USER="gettransf"
PASS="TcpLQPhXB3MBPAbZvtRn"
FTPURL="ftp://$USER:$PASS@$HOST"
LCD="/etc/nixos/greet"
RCD="/domains/gettransfer.lt/public_html"
DELETE="--delete"
lftp -c "set ftp:list-options -a;
set cmd:fail-exit yes;
# set ssl:verify-certificate false;
open '$FTPURL';
lcd $LCD;
cd $RCD;
mirror --reverse \
       $DELETE \
       --verbose \
       --exclude-glob .git/ \
       --exclude-glob vendor/phpunit/"
