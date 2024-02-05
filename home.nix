{ inputs, include, ... }: {
  home.stateVersion = "23.05";
  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./vim
  ]
  ++ include ./home
  ++ include ./home/programs
  ++ include ./home/services;

  home.shellAliases = { };

  home.sessionVariables = {
    FOO = "";
    BROWSER = "firefox";
    MOZ_X11_EGL = "1";
    # SYSTEM = config.system.name;
  };
  home.file = { };
}
