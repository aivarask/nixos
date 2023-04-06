_: {
  imports = [ ./default.nix ];
  home = {
    file.".dwm-status.toml".text = builtins.readFile ./dwm-status_dell.toml + builtins.readFile ./dwm-status.toml;
  };
}
