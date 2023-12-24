autoload bashcompinit && bashcompinit
source /etc/nixos/share/zsh/wp-completion.bash
source ${XDG_CONFIG_HOME}/tabtab/zsh/__tabtab.zsh # https://github.com/denosaurs/tabtab

source /etc/nixos/zsh/archwiki.zsh
source /etc/nixos/zsh/bindings.zsh
source /etc/nixos/zsh/functions.zsh

foo() {
  echo $*
  # define completion inside module
  # compdef _foo foo
}
