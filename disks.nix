{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    disko
    qemu
    git
    sysz
    gdu
    duf
    dust
    jmtpfs
    android-file-transfer
    nfs-utils
    inotify-tools
    fswatch
    mtools
    parted
    gparted
  ];
}
