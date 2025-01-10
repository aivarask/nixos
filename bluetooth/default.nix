# https://wiki.nixos.org/wiki/Bluetooth
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    dmenu-bluetooth
    overskride
    bluetuith
    bluetui
  ];
  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
  };
  services.mpris-proxy.enable = true;
  services.blueman.enable = true;
  # hm
  # services.blueman-applet.enable = true;
}
