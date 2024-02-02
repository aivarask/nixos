{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    tabbed
    dmenu
    st
    dwm
    emojipick
  ];
}
