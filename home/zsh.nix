{pkgs, ...}: {
  programs = {
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {add_newline = false;};
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    nix-index.enable = true;
    zsh = {
      enable = true;
      autocd = true;
      cdpath = ["/etc/nixos"];
      completionInit = "autoload -U compinit && compinit"; # default value
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      history = {
        size = 10000;
        extended = true;
      };
      initExtra = ''
        unalias run-help
        autoload -Uz run-help
        source /etc/nixos/functions.zsh
        source /etc/nixos/bindings.zsh
        eval "$(direnv hook zsh)"
        bindkey "''${key[Up]}" up-line-or-search
        fpath=(${pkgs.zsh-completions.outPath}/share/zsh/site-functions $fpath)
      '';
      plugins = [
        {
          # zsh-completions
          name = "zsh-completions";
          file = "zsh-completions.plugin.zsh";
          src = pkgs.zsh-completions;
        }
        {
          # zsh-nix-shell
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.zsh-nix-shell;
        }
        {
          # zsh-forgit
          name = "forgit";
          file = "forgit.plugin.zsh";
          src = pkgs.zsh-forgit;
        }
        {
          # zsh-fzf-tab
          name = "fzf-tab";
          file = "fzf-tab.plugin.zsh";
          src = pkgs.zsh-fzf-tab;
        }
        {
          # zsh-autocomplete
          name = "zsh-autocomplete";
          file = "zsh-autocomplete.plugin.zsh";
          src = pkgs.zsh-autocomplete;
        }
        {
          # zsh-better-npm-completion
          name = "zsh-better-npm-completion";
          file = "zsh-better-npm-completion.plugin.zsh";
          src = pkgs.zsh-better-npm-completion;
        }
      ];
    };
  };
}
