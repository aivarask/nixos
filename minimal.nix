# https://nixos.wiki/wiki/Creating_a_NixOS_live_CD
# wireless https://nixos.org/manual/nixos/stable/index.html#sec-building-image-drivers
# build nix build .\#nixosConfigurations.exampleIso.config.system.build.isoImage
# test https://nixos.wiki/wiki/Creating_a_NixOS_live_CD#Testing_the_image
# emulate qemu-system-x86_64 -enable-kvm -m 256 -cdrom result/iso/nixos-*.iso
#     https://wiki.nixos.org/wiki/QEMU
# build nix build .\#nixosConfigurations.exampleIso.config.system.build.isoImage &&
# partition
# UEFI(GPT) https://nixos.org/manual/nixos/stable/#sec-installation-manual-partitioning-UEFI
# format https://nixos.org/manual/nixos/stable/#sec-installation-manual-partitioning-formatting
# install https://nixos.org/manual/nixos/stable/#sec-installation-manual-installing
{
  pkgs,
  modulesPath,
  config,
  lib,
  ...
}@args:
{
  environment.systemPackages = with pkgs; [
    systemctl-tui
    fzf
    neovim
    disko
    htop
    pistol
    lf
  ];
  # customization
  programs.bash.interactiveShellInit = ''
    shopt -s autocd
    # shopt -s autocd
    set -o noclobber
    shopt -s checkwinsize
    echo 'woo'
  '';
  # dns https://wiki.nixos.org/wiki/NetworkManager#DNS_Management
  # iwd https://nixos.wiki/wiki/Iwd
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  # networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings = {
    # https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/iwd.config.rst
    # General.EnableNetworkConfiguration = true;
    IPv4.SendHostname = true;
    Network.NameResolvingService = "resolvconf"; # Values: resolvconf, **systemd**, none
    Network.EnableIPv6 = false;
    Settings.AutoConnect = true;
    # Scan.DisablePeriodicScan=true;
  };
  # SSH https://nixos.wiki/wiki/Creating_a_NixOS_live_CD#SSH
  # https://nixos.wiki/wiki/SSH_public_key_authentication
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHEs8Ir7meX21p/xxIfwz/Z9vYDF0VCE29t4pML7iF/X"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINCfPZBHEBgGHptxSr6E4DvnztZQ8+MXvui0Bz9LJJM3"
  ]
  ++ (args.extraPublicKeys or [ ]);

  environment.etc."disko-config.nix".source = ./disk-nvme.nix;
  systemd.tmpfiles.rules = [
    "f /home/nixos/disko-config.nix - - - - ${builtins.readFile ./disk-nvme.nix}"
    "C+ /home/nixos/nixos - - - 10d ${./.}"
  ];
  # systemd.tmpfiles.settings."disko-config"."/tmp/disk-config.nix".f.argument = builtins.readFile ./common/disko/gpt-bios-compat.nix;
  # static_ip https://nixos.wiki/wiki/Creating_a_NixOS_live_CD#Static_IP_Address
  # wifi https://nixos.org/manual/nixos/stable/index.html#sec-building-image-drivers
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "broadcom-sta-6.30.223.271-59-6.18.3"
  ];
  boot.initrd.kernelModules = [ "wl" ];
  boot.kernelModules = [
    "kvm-intel"
    "wl"
  ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  nix.settings.experimental-features = "nix-command flakes pipe-operators";
}
