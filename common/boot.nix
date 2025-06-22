{ lib, ... }:
{
  boot.tmp.cleanOnBoot = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.systemd-boot.enable = lib.mkDefault true;
  boot.loader.systemd-boot.netbootxyz.enable = true;
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 100001;
    "fs.inotify.max_queued_events" = 100001;
  };
}
