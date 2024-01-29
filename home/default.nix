{ pkgs, lib, inputs, config, include, ... }: {
  imports = [
    ./colorScheme.nix
    ./pointerCursor.nix
    ./xdg.nix
    ../vim
  ]
  ++ include ./programs
  ++ include ./services;

  home.stateVersion = "23.05";

  home.shellAliases = { };

  home.sessionVariables = {
    BROWSER = "firefox";
    MOZ_X11_EGL = "1";
    # SYSTEM = config.system.name;
  };

  home = {
    file = {
      # ".dwm-status.toml".text = builtins.readFile ../files/dwm-status_dell.toml + builtins.readFile ../files/dwm-status.toml;
    };
  };

}
