{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # polkit-gnome
    gparted
    gnome-calculator
    gnome-network-displays
    gnome-system-monitor
    gnome-themes-extra
    gnome-tweaks
    dconf-editor
    lxappearance
    nwg-panel
    nwg-dock
    nwg-icon-picker
    nwg-menu
    nwg-drawer
    nwg-clipman
    nwg-dock
    nwg-displays
  ];
}
