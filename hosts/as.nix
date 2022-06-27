{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./as-hardware.nix
      ./common.nix
    ];

  networking.hostName = "as";
  networking.hostId = "8425e349";
  networking.useDHCP = false;
  networking.interfaces.enp2s0f2.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;
  system.stateVersion = "22.05";

  services.xserver = {
    videoDrivers = [ "modesetting" ];
    useGlamor = true;
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
  };
  hardware.bluetooth.enable = false;
  services.blueman.enable = false;
}

