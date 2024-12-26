#!/usr/bin/env zsh

set -x

# echo $(dirname $0)/zsh.foo.zsh
# readlink -f ${(%):-%N}
# source $(dirname $0)
echo ${(%):-%N}
