{ pkgs, inputs, ... }: {
  imports = [
    ./default.nix
    ./colors.nix
  ];
  home = {
    file.".dwm-status.toml".text = builtins.readFile ./files/dwm-status_dell.toml + builtins.readFile ./files/dwm-status.toml;
  };
  services.blueman-applet.enable = true;
  services.mpris-proxy.enable = true;
  programs.alacritty.settings.font.size = 7.0;
}
