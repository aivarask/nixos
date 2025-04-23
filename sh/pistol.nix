{ config, SELF, ... }:
{
  programs.pistol.enable = true;
  xdg.configFile."pistol/pistol.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${SELF}/sh/pistol.conf";
}
