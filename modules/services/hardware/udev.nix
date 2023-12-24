{pkgs, ...}: {
  services.udev.packages = [
    pkgs.mixxx
    pkgs.bitwig-studio
    # pkgs.android-udev-rules
  ];
}
