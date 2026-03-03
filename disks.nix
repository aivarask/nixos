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

    # incus
    buildah
    podman
    skopeo
    podman-tui
    # MTP (Media transfer protocol)
    # https://nixos.wiki/wiki/MTP
    # https://wiki.archlinux.org/title/Media_Transfer_Protocol
    # lsusb
    # gio mount "mtp://[usb:001,006]/"
    # mtpfs
    # simple-mtpfs
    # go-mtpfs
    jmtpfs
    android-file-transfer

    inotify-tools
    fswatch

    udiskie
    parted
    gparted
  ];
}
