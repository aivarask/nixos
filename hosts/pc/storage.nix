{ lib, ... }:
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
  fileSystems."/mnt/dell_music" = {
    device = "//192.168.1.180/music";
    fsType = "cifs";
    options = [
      "username=root"
      "users"
      "noauto"
      "credentials=/etc/nixos/smb-secrets"
    ];
  };
}
