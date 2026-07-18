# B450 AORUS M
{
  config,
  lib,
  modulesPath,
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
  fileSystems."/hdd" = {
    device = "/dev/disk/by-label/hdd";
    fsType = "ext4";
    neededForBoot = false;
    options = [ "noatime" ];
  };
  # fileSystems."/media" = {
  #   device = "/dev/disk/by-label/hdd";
  #   fsType = "ext4";
  #   options = [
  #     "users" # Allows any user to mount and unmount
  #     "nofail" # Prevent system from failing if this drive doesn't mount
  #     "exec" # Permit execution of binaries and other executable files
  #   ];
  # };

  # services.nfs.server.enable = false;
  # services.nfs.server.exports = ''
  #   /root/Videos     minimal(rw,nohide,insecure,no_subtree_check)
  #   /root/Music     minimal(rw,nohide,insecure,no_subtree_check)
  # '';
  networking.firewall.allowedTCPPorts = [ 2049 ];
  networking.firewall.allowedUDPPorts = [ 2049 ];

}
