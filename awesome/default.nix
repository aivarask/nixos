{ config, ... }:
{
  # https://awesomewm.org/doc/api/sample%20files/rc.lua.html
  xdg.configFile."awesome".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/awesome";
}
