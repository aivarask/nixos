{ pkgs, ... }:
{
  xdg.desktopEntries.alacritty = {
    name = "Alacritty";
    exec = "${pkgs.alacritty}/bin/alacritty";
  };
}
