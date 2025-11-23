# links
https://github.com/sxyazi/yazi
https://unmovedcentre.com/posts/remote-install-nixos-config/

# tools

dd if=/dev/zero of=/tmp/temp oflag=direct bs=128k count=16k

Permissions	Octal Value	Binary Value	Description
---	0	000	No permission
--x	1	001	only permission to execute 
-w-	2	010	only permission to write
-wx	3	011	permission to write and execute
r--	4	100	only permission to read
r-x	5	101	permission to read and execute
rw-	6	110	permission to read and write
rwx	7	111	permission to do all three, i.e. read, write and execute

# nix pkgs override

(bitwig-studio.override {
  bitwig-studio-unwrapped = bitwig-studio5-unwrapped.override {
    vulkan-loader = pkgs-24-11.vulkan-loader;
  };
})

# zsh

https://labex.io/tutorials/linux-how-to-debug-zsh-script-runtime-errors-419331
https://www.lshell.com/posts/2021/12/zsh-bindkey-table/

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
