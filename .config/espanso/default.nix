{
  pkgs,
  xdgconf,
  config,
  lib,
  ...
}:
{

  home.packages = [
    pkgs.espanso-wayland
  ];
  services.espanso.enable = false;
  xdg.configFile."espanso" = {
    source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/espanso";
    enable = true;
    force = true;
    recursive = true;
  };
}
