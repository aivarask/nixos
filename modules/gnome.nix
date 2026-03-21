{ pkgs, ... }:
{
  services.gnome.gnome-keyring.enable = true;
  environment.systemPackages = with pkgs; [
    grc
    # polkit-gnome
    gparted
    gnome-disks
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
