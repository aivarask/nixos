#!/usr/bin/env bash

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
