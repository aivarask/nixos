{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    tabbed
    dmenu
    st
    dwm
    dwm-status
    slstatus
    emojipick
  ];
}
