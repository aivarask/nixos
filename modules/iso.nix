{ modulesPath, ... }:
{
  imports = [
    # https://github.com/NixOS/nixpkgs/tree/master/nixos/modules/installer/cd-dvd
    # (modulesPath + "/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix")
    (modulesPath + "/installer/cd-dvd/iso-image.nix")
  ];
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
