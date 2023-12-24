{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    autocd = true;
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
    history = {
      size = 10000;
      extended = true;
    };
    dotDir = ".config/zsh";
    cdpath = [
      "/etc/nixos"
    ];
    dirHashes = {
      dl = "$HOME/Downloads";
    };
    initExtraBeforeCompInit = ''
      # <<< initExtraBeforeCompinit
      # >>>
    '';
    enableCompletion = true;
    completionInit = ''
      # <<< completionInit
      autoload -U compinit && compinit
      # >>>
    '';
    initExtra = ''
      # <<< initExtra
      source /etc/nixos/zsh/main.zsh
      # source ~/.config/tabtab/zsh/__tabtab.zsh # https://github.com/denosaurs/tabtab
      # eval "$(direnv hook zsh)" # https://github.com/direnv/direnv
      # >>>
    '';
    plugins = [
      {
        # https://github.com/chisui/zsh-nix-shell
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.zsh-nix-shell;
      }
      # zsh-forgit zsh-fzf-tab
    ];
  };
}
