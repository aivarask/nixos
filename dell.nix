{
  pkgs,
  lib,
  config,
  ...
}:
{
  fileSystems."/" = {
    device = "/dev/disk/by-partlabel/disk-main-root";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-partlabel/disk-main-ESP";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  systemd.mounts = [
    {
      type = "nfs";
      mountConfig = {
        Options = "noatime";
      };
      what = "pc:/Music";
      where = "/root/Music/pc";
    }
  ];
  systemd.automounts = [
    {
      wantedBy = [ "multi-user.target" ];
      automountConfig = {
        TimeoutIdleSec = "600";
      };
      where = "/root/Music/pc";
    }
  ];
}
