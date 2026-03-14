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

    # lsusb
    # gio mount "mtp://[usb:001,006]/"
    # mtpfs
    # simple-mtpfs
    # go-mtpfs
  ];
}
