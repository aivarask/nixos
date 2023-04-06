_: {
  imports = [ ./default.nix ];
  home = {
    file.".dwm-status.toml".text = builtins.readFile ./dwm-status_pc.toml + builtins.readFile ./dwm-status.toml;
  };
}
