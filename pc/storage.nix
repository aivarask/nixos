{ ... }:
{
  fileSystems = {
    "/" = {
      device = "zroot/root/nixos";
      fsType = "zfs";
    };
    "/home" = {
      device = "zroot/home";
      fsType = "zfs";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/CE3C-0926";
      fsType = "vfat";
    };
  };
  swapDevices = [
  ];
}
