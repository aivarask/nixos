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

  hardware.nvidia.open = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /export         minimal(rw,fsid=0,no_subtree_check)
    /export/music   minimal(rw,nohide,insecure,no_subtree_check)
  '';
  # /export         192.168.0.226(rw,fsid=0,no_subtree_check)
  # /export/music   192.168.1.226(rw,nohide,insecure,no_subtree_check)
  networking.firewall.allowedTCPPorts = [
    111
    2049
    4000
    4001
    4002
    20048
  ];
  networking.firewall.allowedUDPPorts = [
    111
    2049
    4000
    4001
    4002
    20048
  ];

  # programs.steam.enable = true;
  # programs.steam.remotePlay.openFirewall = true;
  # programs.steam.dedicatedServer.openFirewall = true;
  # programs.steam.extraCompatPackages = with pkgs; [
  #   proton-ge-bin
  # ];
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
