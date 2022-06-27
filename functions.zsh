precmd() {print -Pn "\e]0;${PWD/#$HOME/~} [$(history | tail -n1 | awk '{for (i=2;i<=NF-1;i++) printf $i " "; print $NF}')]\a"}

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
