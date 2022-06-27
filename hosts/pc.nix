{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./pc-hardware.nix
      ./common.nix
    ];

  networking.hostName = "pc";
  networking.hostId = "007f0200";
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.wlp5s0.useDHCP = true;
  networking.wireless.driver = "wext"; # "TP-Link TL-WN881 ND"

  networking.interfaces.wlp5s0.ipv4.addresses = [{
    address = "192.168.1.111";
    prefixLength = 24;
  }];
  networking.defaultGateway = "192.168.1.1";


  system.stateVersion = "22.05";
  hardware.nvidia = { modesetting.enable = true; };
  hardware.video.hidpi.enable = lib.mkDefault true;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver = {
    # https://nixos.wiki/wiki/Xorg
    # dpi = 168; # 96*1.75
    dpi = 144; # 96*1.5
  };
}
