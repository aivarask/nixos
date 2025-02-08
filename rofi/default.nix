{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    font = "Droid Sans Mono 14";
    plugins = [ pkgs.rofi-calc ];
    extraConfig = {
      modi = "drun,emoji,ssh";
      kb-primary-paste = "Control+V,Shift+Insert";
      kb-secondary-paste = "Control+v,Insert";
    };
    theme = ./gruvbox-dark-soft.rasi;
  };

}
