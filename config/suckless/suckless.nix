{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    dmenu
    dwm
    st
    tabbed
    wmname
    emojipick
    surf
    svkbd
  ];
}
