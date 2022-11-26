{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./dell-hardware.nix
      ./common.nix
    ];
  networking.hostName = "dell";
  networking.hostId = "8425e349";
  networking.useDHCP = false;
  networking.interfaces.wlp59s0.useDHCP = true;

  networking.interfaces.wlp59s0.ipv4.addresses = [{
    address = "192.168.1.222";
    prefixLength = 24;
  }];
  networking.defaultGateway = "192.168.1.1";

  # system.stateVersion = "22.05";
  # hardware.nvidia = { modesetting.enable = true; };
  # hardware.video.hidpi.enable = lib.mkDefault true;
  # services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver = {
    # https://nixos.wiki/wiki/Xorg
    dpi = 168; # 96*1.75
    # dpi = 144; # 96*1.5
    # dpi = 120; # 96*1.25
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
  };
  hardware.bluetooth.enable = false;
  services.blueman.enable = false;
}
