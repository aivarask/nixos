{ pkgs, ... }:
{
  # https://wiki.archlinux.org/title/Rofi
  # https://mynixos.com/home-manager/options/programs.rofi
  # https://github.com/davatorium/rofi
  programs.rofi = {
    enable = true;
    font = "Droid Sans Mono 28";
    plugins = [ pkgs.rofi-calc ];
    # https://davatorium.github.io/rofi/CONFIG/
    extraConfig = {
      modes = "window,drun,run,ssh,calc";
      # modi = "drun";
      # kb-primary-paste = "Control+V,Shift+Insert";
      # kb-secondary-paste = "Control+v,Insert";
    };
    # theme = ./gruvbox-dark-soft.rasi;
  };

}
