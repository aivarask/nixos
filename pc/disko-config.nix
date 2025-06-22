let
  boot = {
    name = "ESP";
    start = "1M";
    end = "500M";
    bootable = true;
    content = {
      type = "filesystem";
      format = "vfat";
      mountpoint = "/boot";
      mountOptions = [ "umask=0077" ];
    };
  };
in
{
  disko.devices.disk."ssd240".device = "/dev/sdb";
  disko.devices.disk."ssd240" = {
    # 223.57 GiB, 240057409536 bytes, 468862128 sectors
    # Disk model: PH4-CE240
    # Disk identifier: 1B3BF3FE-0F1D-4879-8AC9-DCA602665EB8
  };

  disko.devices.disk."udisk".device = "/dev/sda";
  disko.devices.disk."udisk" = {
    # 7.62 GiB, 8178892800 bytes, 15974400 sectors
    # Disk model: UDisk
    # Disk identifier: D51EF88A-7A20-4F5B-81CC-5C62F55BFF77
    type = "disk";
    content = {
      type = "table";
      format = "gpt";
      partitions = [
        {
          name = "root";
          start = "500M";
          end = "100%";
          part-type = "primary";
          # bootable = true;
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/udisk";
          };
        }
      ];
    };
  };

  disko.devices.disk."slim".device = "/dev/sdc";
  disko.devices.disk."slim" = {
    # 3.74 GiB, 4010803200 bytes, 7833600 sectors
    # Disk model: FLASH DRIVE
    type = "disk";
    content = {
      type = "table";
      format = "gpt";
      partitions = [
        {
          name = "root";
          start = "500M";
          end = "100%";
          part-type = "primary";
          # bootable = true;
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/slim";
          };
        }
      ];
    };
  };
}
