# showkey -a
# infocmp -cL
# bindkey -L
# https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/programs/zsh/zinputrc

bindkey '^[[Z' reverse-menu-complete # S-Tab

bindkey '^ ' forward-word # C-Space
# bindkey '^H' backward-kill-word  # C-BS
bindkey '^[[1;5C' autosuggest-accept # C-Right
bindkey '^[[3;5~' kill-word          # C-Del

bindkey "^[OP" "run-help"        # F1
bindkey -s "^[[15~" "exec zsh\n" # F5

bindkey -s "^F" "fzf -m --preview 'pistol {}'\n"
bindkey -s "^G" "Rg\n"
