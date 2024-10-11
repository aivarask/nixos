{ pkgs, ... }:
{
  programs.zsh = {
    sessionVariables = { };
    enable = true;
    autocd = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    dotDir = ".config/zsh";
    history = {
      size = 10000;
      extended = true;
    };
    initExtraBeforeCompInit = ''
      # <<< initExtraBeforeCompinit
      precmd() {
      	print -Pn "\e]83;title \"$1\"\a"
      	print -Pn "\e]0;$PWD $TERM\a"
      }
      preexec() {
      	print -Pn "\e]83;title \"$1\"\a"
      	print -Pn "\e]0;$PWD $1\a"
      }
      fpath+=('/etc/nixos/zsh/site-functions')
      # source /etc/nixos/zsh/_bcomp.zsh
      # >>>
    '';
    # fpath+=(${pkgs.luajitPackages.busted}/share/zsh/site-functions)
    completionInit = ''
      # <<< completionInit
      fpath+=(${pkgs.zig-shell-completions}/share/zsh/site-functions)

      # autoload -U +X bashcompinit && bashcompinit
      # autoload -U compinit && compinit
      # autoload -U +X compinit && compinit
      # compinit

      # autoload -U compinit
      # source /etc/nixos/zsh/site-functions/_foo
      # source /etc/nixos/zsh/site-functions/_wp
      # source /etc/nixos/zsh/_comp.zsh
      # >>>
    '';
    initExtra = ''
      # <<< initExtra
      source /etc/nixos/zsh/_init.zsh
      # >>>
    '';
    plugins = [
      # pkgs.zsh-autocomplete
      # {
      #   # https://github.com/chisui/zsh-nix-shell
      #   name = "zsh-nix-shell";
      #   file = "nix-shell.plugin.zsh";
      #   src = pkgs.zsh-nix-shell;
      # }
      # zsh-forgit zsh-fzf-tab
    ];
  };
}
