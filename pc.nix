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
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  networking.hostName = "pc";
  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.fancontrol.enable = false;
  hardware.fancontrol.config = "";

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
  fileSystems."/var/lib/transmission/watchdir" = {
    depends = [
      "/root/Downloads"
      "/var/lib/transmission"
    ];
    device = "/root/Downloads";
    fsType = "none";
    options = [
      "bind"
      # "ro"
    ];
  };

  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /export         minimal(rw,fsid=0,no_subtree_check)
    /export/music   minimal(rw,nohide,insecure,no_subtree_check)
    /root/Video     minimal(rw,nohide,insecure,no_subtree_check)
  '';
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

}
