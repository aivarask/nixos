{ modulesPath, ... }:
{
  imports = [
    # https://github.com/NixOS/nixpkgs/tree/master/nixos/modules/installer/cd-dvd
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix")
  ];
  isoImage.squashfsCompression = "gzip -Xcompression-level 1"; # compression https://nixos.wiki/wiki/Creating_a_NixOS_live_CD#Building_faster
  # nixpkgs.hostPlatform = system;
  # systemd.user.services.startup = {
  #   description = "...";
  #   # serviceConfig.PassEnvironment = "DISPLAY";
  #   script = ''
  #     git clone 'https://github.com/aivarask/nixos.git' /home/nixos/nixos
  #
  #     echo 'zoo' > /home/nixos/startup_script
  #   '';
  #   wantedBy = [
  #     "multi-user.target"
  #     "network-online.target"
  #   ]; # starts after login
  # };
}
