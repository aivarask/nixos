{ config, ... }:
{
  home.file.".mixxx/controllers/_Behringer-CMD-MM1-scripts.js".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/mixxx/_Behringer-CMD-MM1-scripts.js";
  home.file.".mixxx/controllers/_Behringer CMD MM-1.midi.xml".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/mixxx/_Behringer CMD MM-1.midi.xml";
}
