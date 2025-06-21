{ lib, inputs, ... }:
{
  inputs.disko.devices = {
    disk.disk1 = {
      device = lib.mkDefault "/dev/sda";
      #      type = "disk";
      content = {
        type = "table";
        format = "msdos";
        partitions = [
          {
            part-type = "primary";
            fs-type = "btrfs";
            name = "root";
            bootable = true;
            content = {
              type = "filesystem";
              format = "btrfs";
              extraArgs = [
                "-f"
                "-O block-group-tree"
              ];
              mountpoint = "/";
              mountOptions = [ "compress=zstd" ];
            };
          }
        ];
      };
    };
  };

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
