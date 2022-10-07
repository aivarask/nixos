autoload -Uz history-beginning-search-menu
zle -N history-beginning-search-menu
bindkey '^X^X' history-beginning-search-menu

bindkey -M emacs '^[[3;5~' kill-word # c-del
bindkey '^H' backward-kill-word
bindkey '^ ' forward-word            # c-space
bindkey '^[[1;5C' autosuggest-accept # c-right

bindkey "^[OP" "run-help"        # F1
bindkey -s "^[[15~" "exec zsh\n" # F5
bindkey -s "^[[24;5~" "up\n"     # C-F12

bindkey -s "^E" "fzf -m --preview 'pistol {}' | xargs -r $EDITOR \n"
bindkey -s "^F" "fzf -m --preview 'pistol {}'\n"
bindkey -s "^G" "fzl\n"

bindkey -s "^O" "lf\n"
# showkey -a
# infocmp -cL
# bindkey -L
