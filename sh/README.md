# Links

https://labex.io/tutorials/linux-how-to-debug-zsh-script-runtime-errors-419331
https://www.lshell.com/posts/2021/12/zsh-bindkey-table/

# zsh

```bash
# setopt
set -o errexit
set -o nounset
set -o xtrace

echo $SELF

# script relative
echo ${0}
echo ${0:a}
echo ${0:a:h}/bin

# relative but with symlinks
echo $(readlink $0)
echo ${$(readlink $0):h}
```
