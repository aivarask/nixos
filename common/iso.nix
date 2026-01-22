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
  # https://github.com/NixOS/nixpkgs/tree/master/nixos/modules/installer/cd-dvd
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix")
    # (modulesPath + "/installer/cd-dvd/installation-cd-graphical-gnome.nix")
  ];
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
  networking.networkmanager.wifi.backend = "iwd";
  networking.wireless.iwd.settings = {
    # https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/iwd.config.rst
    # General.EnableNetworkConfiguration = true;
    IPv4.SendHostname = true;
    # IPv4 = {
    #   Address = "192.168.1.100";
    #   Netmask = "255.255.255.0";
    #   Gateway = "192.168.1.1";
    #   Broadcast = "192.168.1.255";
    #   DNS = "192.168.1.1";
    # };
    Network.NameResolvingService = "resolvconf"; # Values: resolvconf, **systemd**, none
    Network.EnableIPv6 = false;
    # IPv6.Enabled = false;
    Settings.AutoConnect = true;

    # Scan.DisablePeriodicScan=true;
  };
  # SSH https://nixos.wiki/wiki/Creating_a_NixOS_live_CD#SSH
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHEs8Ir7meX21p/xxIfwz/Z9vYDF0VCE29t4pML7iF/X"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINCfPZBHEBgGHptxSr6E4DvnztZQ8+MXvui0Bz9LJJM3"
  ]
  ++ (args.extraPublicKeys or [ ]);

  # systemd.tmpfiles.rules = [
  #   "f /home/nixos/disko-config.nix - - - - ${builtins.readFile ./common/dell/disko-gpt-bios.nix}"
  # ];
  environment.etc."disko-config.nix".source = ./common/disko-config.nix;

  # systemd.tmpfiles.settings = {
  #   "disko-config" = {
  #     "/tmp/disk-config.nix" = {
  #       f = {
  #         argument = builtins.readFile ./common/disko/gpt-bios-compat.nix;
  #       };
  #     };
  #   };
  # };
  # static_ip https://nixos.wiki/wiki/Creating_a_NixOS_live_CD#Static_IP_Address
  # networking = lib.mkIf false {
  #   usePredictableInterfaceNames = false;
  #   interfaces.eth0.ipv4.addresses = [
  #     {
  #       address = "192.168.1.100";
  #       prefixLength = 24;
  #     }
  #   ];
  #   defaultGateway = "192.168.1.1";
  #   nameservers = [ "8.8.8.8" ];
  # };
  # compression https://nixos.wiki/wiki/Creating_a_NixOS_live_CD#Building_faster
  # squashfsCompression 	Time 	Size
  # lz4 	100s 	59%
  # gzip -Xcompression-level 1 	105s 	52%
  # gzip 	210s 	49%
  # xz -Xdict-size 100% (default) 	450s 	43%
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";

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
