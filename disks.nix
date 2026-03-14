{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    disko
    qemu

    git
    systemctl-tui
    sysz
    gdu
    duf
    dust

    # https://nixos.wiki/wiki/MTP
    # https://wiki.archlinux.org/title/Media_Transfer_Protocol
    # lsusb
    # gio mount "mtp://[usb:001,006]/"
    # mtpfs
    # simple-mtpfs
    # go-mtpfs
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
