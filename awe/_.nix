{ pkgs, ... }:
{
  home.shellAliases = {
    xs = "xinit $XINITRC -- $XSERVERRC";
    xa = "startx $XINITRC awesome";
  };
  home.packages = with pkgs; [
    awesome
    luajitPackages.vicious
  ];
}
