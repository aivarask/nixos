{ pkgs, config, ... }:
{
  xdg.configFile."mimeapps.list".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/xdg/mimeapps.list";
  # xdg.dataFile."applications/alacritty.desktop".source =
  #   config.lib.file.mkOutOfStoreSymlink "/etc/nixos/xdg/alacritty.desktop";
}
