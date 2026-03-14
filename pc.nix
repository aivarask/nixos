# B450 AORUS M
{
  config,
  lib,
  modulesPath,
  pkgs,
  inputs,
  ...
}:
{
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXBOOT";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };
  swapDevices = [ ];
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  networking.hostName = "pc";
  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.fancontrol.enable = false;
  hardware.fancontrol.config = "";

  services.udev.extraRules =
    let
      bash = "${pkgs.bash}/bin/bash";
      ddcciDev = "DP-1";
      ddcciNode = "/sys/bus/i2c/devices/i2c-1/new_device";
    in
    ''
      SUBSYSTEM=="i2c", ACTION=="add", ATTR{name}=="${ddcciDev}", RUN+="${bash} -c 'sleep 30; printf ddcci\ 0x37 > ${ddcciNode}'"
    '';
}
