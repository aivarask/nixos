{ lib, ... }: {
  # dell
  services.blueman-applet.enable = true;
  services.mpris-proxy.enable = true; # Using Bluetooth headset buttons to control media player
}
