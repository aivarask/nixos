# https://man.archlinux.org/man/zshmisc.1#Hook_Functions

precmd() {
  print -Pn "\e]83;title \"$1\"\a"
  print -Pn "\e]0;$TERM $PWD\a"
}
preexec() {
  print -Pn "\e]83;title \"$1\"\a"
  print -Pn "\e]0;$1 $PWD\a"
}
