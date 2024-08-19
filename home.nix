{ include, nix-colors, ... }: {
  home.stateVersion = "23.05";
  colorScheme = nix-colors.colorSchemes.gruvbox-dark-medium;
  imports = [ nix-colors.homeManagerModules.default ]
    ++ include ./home
    ++ include ./home/programs
    ++ include ./home/services
    ++ include ./plugin
    ++ include ./tdd
  ;
  home.shellAliases = { };
  home.sessionVariables = {
    BROWSER = "firefox";
    MOZ_X11_EGL = "1";
    # SYSTEM = config.system.name;
  };
  home.file = { };
}
