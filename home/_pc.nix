_: {
  imports = [./default.nix];
  home = {
    file.".dwm-status.toml".text = builtins.readFile ./files/dwm-status_pc.toml + builtins.readFile ./files/dwm-status.toml;
  };
}
