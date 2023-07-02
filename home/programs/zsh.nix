{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    autocd = true;
    cdpath = ["/etc/nixos"];
    history = {
      size = 10000;
      extended = true;
    };
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    localVariables = {
      FOO = "zsh.localVariables";
    };
    initExtraBeforeCompInit = ''
    '';
    enableCompletion = false;
    # completionInit = "autoload -U compinit";
    completionInit = "";
    initExtra = ''
      source /etc/nixos/functions.zsh
      source /etc/nixos/bindings.zsh
      eval "$(direnv hook zsh)"
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
        name = "zsh-forgit";
        file = "forgit.plugin.zsh";
        src = pkgs.zsh-forgit;
      }
      # {
      #   # zsh-fzf-tab
      #   name = "fzf-tab";
      #   file = "fzf-tab.plugin.zsh";
      #   src = pkgs.zsh-fzf-tab;
      # }
    ];
    # zplug = {
    #   enable = true;
    #   plugins = [
    #   # zsh-autocomplete
    #     {name = "marlonrichert/zsh-autocomplete";}
    #   ];
    # };
  };
}
