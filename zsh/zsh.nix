{ ... }:
{
  programs.bash =
    {
    };
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
    profileExtra = '''';
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
      # >>>
    '';
    # fpath+=(${pkgs.luajitPackages.busted}/share/zsh/site-functions)
    completionInit = ''
      # <<< completionInit
      # autoload -U +X bashcompinit
      # autoload -U +X compinit
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
