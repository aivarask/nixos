# https://wiki.archlinux.org/title/Zsh

# 3 https://wiki.archlinux.org/title/Zsh#Configure_Zsh

# 3.3 Command completion
# https://wiki.archlinux.org/title/Zsh#Command_completion
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select

# 4 Tips and Tricks
# https://wiki.archlinux.org/title/Zsh#Tips_and_tricks

# 4.4 Help command
# https://wiki.archlinux.org/title/Zsh#Help_command
autoload -Uz run-help
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help
autoload -Uz run-help-git run-help-nix run-help-ip run-help-openssl run-help-sudo

# 4.6 Bind key to ncurses application
# https://wiki.archlinux.org/title/Zsh#Bind_key_to_ncurses_application
ncmpcppShow() {
  BUFFER="ncmpcpp"
  zle accept-line
}
zle -N ncmpcppShow
bindkey '^[\' ncmpcppShow

# 4.7 File manager kay binds
# https://wiki.archlinux.org/title/Zsh#File_manager_key_binds
cdUndoKey() {
  popd
  zle reset-prompt
  print
  ls
  zle reset-prompt
}

cdParentKey() {
  pushd ..
  zle reset-prompt
  print
  ls
  zle reset-prompt
}

zle -N cdParentKey
zle -N cdUndoKey
bindkey '^[[1;3A' cdParentKey
bindkey '^[[1;3D' cdUndoKey
