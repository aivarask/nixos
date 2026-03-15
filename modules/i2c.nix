{ pkgs, config, ... }:
{
  boot.kernelModules = [
    "i2c-dev"
    "ddcci-backlight"
  ];
  boot.extraModulePackages = [
    config.boot.kernelPackages.ddcci-driver
  ];
  hardware.i2c.enable = true;
  services.udev.extraRules =
    let
      shell = "${pkgs.zsh}/bin/zsh";
      ddcciDev = "DP-1";
      ddcciNode = "/sys/bus/i2c/devices/i2c-1/new_device";
    in
    ''
      SUBSYSTEM=="i2c", ACTION=="add", ATTR{name}=="${ddcciDev}", RUN+="${shell} -c 'sleep 30; printf ddcci\ 0x37 > ${ddcciNode}'"
    '';
}
