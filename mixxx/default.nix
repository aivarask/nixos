{ config, ... }:
{
  home.file.".mixxx/controllers/_CMD".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/mixxx/Behringer-CMD-MM1-scripts.js";
}
