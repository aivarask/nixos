export FZF_COMPLETION_TRIGGER='~~'

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
