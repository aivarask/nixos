precmd() {
  print -Pn "\e]83;title \"$1\"\a"
  print -Pn "\e]0;$TERM\a"
}
preexec() {
  print -Pn "\e]83;title \"$1\"\a"
  print -Pn "\e]0;$TERM - $1\a"
}

source "$(fzf-share)/key-bindings.zsh"
source "$(fzf-share)/completion.zsh"

export FZF_COMPLETION_TRIGGER='~~'

export FZF_COMPLETION_OPTS='--border --info=inline'

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd) fzf "$@" --preview 'tree -C {} | head -200' ;;
    export | unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    file) fzf "$@" --preview 'file --mime-type {}' ;;
    ssh) fzf "$@" --preview 'dig {}' ;;
    man) fzf "$@" --preview 'man {}' ;;
    vim) fzf "$@" --preview 'pistol {}' ;;
    *) fzf "$@" ;;
  esac
}

function fzf_kill() {
  ps -ef | fzf | awk '{print $2}' | xargs kill -9
}

function fzf_manix {
  manix "" |
    grep '^# ' |
    sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' |
    fzf --preview="manix '{}'" |
    xargs manix
}

# USE LF TO SWITCH DIRECTORIES AND BIND IT TO CTRL-O
lfcd() {
  tmp="$(mktemp)"
  lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    if [ "$dir" != "$(pwd)" ]; then
      cd "$dir" || exit
    fi
  fi
}

lf() {
  local tempfile
  tempfile="$(mktemp)"
  command lf -command "map Q \$echo \$PWD >$tempfile; lf -remote \"send \$id quit\"" "$@"

  if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n "$(pwd)")" ]]; then
    cd -- "$(cat "$tempfile")" || return
  fi
  command rm -f -- "$tempfile" 2>/dev/null
}
