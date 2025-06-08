{ config, ... }:
{
  home.file.".mixxx/controllers/mm1.js".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/audio/mm1.js";
  home.file.".mixxx/controllers/mm1.midi.xml".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/mm1.midi.xml";
}
