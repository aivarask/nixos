{ ... }: {
  programs.zsh = {
    sessionVariables = { };
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
    plugins = [ ];
  };
}
