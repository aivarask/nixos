{
  pkgs,
  xdgconf,
  config,
  lib,
  osConfig,
  ...
}:
{

  home.packages = [
    pkgs.espanso-wayland
  ];
  services.espanso.enable = false;
  xdg.configFile."espanso" = {
    source = osConfig.symlink "${xdgconf}/espanso";
    enable = true;
    force = true;
    recursive = true;
  };
}
