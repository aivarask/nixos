# showkey -a
# infocmp -cL
# bindkey -L

bindkey -M emacs '^[[3;5~' kill-word
bindkey '^H' backward-kill-word
bindkey '^ ' forward-word            # c-space
bindkey '^[[1;5C' autosuggest-accept # c-right

bindkey "^[OP" 'run-help'        # F1
bindkey -s "^[[15~" 'exec zsh\n' # F5
bindkey -s "^[[24;5~" 'up\n'     # C-F12

bindkey -s "^E" 'fzf -m | xargs -r $EDITOR \n'
bindkey -s "^F" 'fzf -m\n'
bindkey -s "^G" 'fzl\n'
