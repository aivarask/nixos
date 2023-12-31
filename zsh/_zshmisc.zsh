# https://man.archlinux.org/man/zshmisc.1#Hook_Functions

precmd() {
  print -Pn "\e]83;title \"$1\"\a"
  print -Pn "\e]0;$PWD $TERM\a"
}
preexec() {
  print -Pn "\e]83;title \"$1\"\a"
  print -Pn "\e]0;$PWD $1\a"
}
