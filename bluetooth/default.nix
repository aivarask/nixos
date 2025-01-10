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
  services.blueman.enable = true;
  # hm
  # services.mpris-proxy.enable = true; # https://specifications.freedesktop.org/mpris-spec/latest/
  # services.blueman-applet.enable = true;
}
