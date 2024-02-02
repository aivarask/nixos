{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    autocd = true;
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
    dotDir = ".config/zsh";
    history = {
      size = 10000;
      extended = true;
    };
    initExtraBeforeCompInit = ''
      # <<< initExtraBeforeCompinit
      source /etc/nixos/zsh/_beforeComp.zsh
      # >>>
    '';
    completionInit = ''
      # <<< completionInit
      source /etc/nixos/zsh/_compInit.zsh
      # >>>
    '';
    initExtra = ''
      # <<< initExtra
      source /etc/nixos/zsh/_initAfter.zsh
      # >>>
    '';
    plugins = [
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
