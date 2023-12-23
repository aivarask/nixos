# showkey -a
# infocmp -cL
# bindkey -L


# Stable
bindkey '^[[Z' reverse-menu-complete # S-Tab

bindkey '^ ' forward-word        # c-space
# bindkey '^H' backward-kill-word  # C-BS
bindkey '^[[1;5C' autosuggest-accept # C-right
bindkey '^[[3;5~' kill-word # c-del

bindkey "^[OP" "run-help"        # F1
bindkey -s "^[OQ" "compinit\n"   # F2
bindkey -s "^[[15~" "exec zsh\n" # F5
bindkey -s "^[[24;5~" "up\n"     # C-F12

bindkey -s "^E" "fzf -m --preview 'pistol {}' | xargs -r $EDITOR \n"
bindkey -s "^F" "fzf -m --preview 'pistol {}'\n"
bindkey -s "^G" "fzl\n"
bindkey -s "^O" "lf\n"
bindkey -s "^N" "nvim\n"

# TODO: backspace and others in console
# https://superuser.com/questions/641095/bash-how-to-globally-fix-h-and-backspace-problems
