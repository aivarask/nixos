_: {
  imports = [./default.nix];
  home = {
    file.".dwm-status.toml".text = builtins.readFile ./dwm-status_dell.toml + builtins.readFile ./dwm-status.toml;
  };
  services.blueman-applet.enable = true;
  services.mpris-proxy.enable = true;
  programs.alacritty.settings.font.size = 8.0;
}
