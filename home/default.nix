{ inputs, include, ... }: {
  home.stateVersion = "23.05";
  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./pointerCursor.nix
    ./xdg.nix
    ../vim
  ]
  ++ include ./programs
  ++ include ./services;



  home.shellAliases = { };

  home.sessionVariables = {
    BROWSER = "firefox";
    MOZ_X11_EGL = "1";
    # SYSTEM = config.system.name;
  };
  home.file = { };
}
