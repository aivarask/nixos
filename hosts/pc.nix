{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./pc-hardware.nix
      ./common.nix
    ];
  system.stateVersion = "22.05";
  console.font = "ter-i16b";

  hardware.video.hidpi.enable = lib.mkDefault true;
  hardware.nvidia = { modesetting.enable = true; };
  hardware.nvidia.powerManagement.enable = true;
  # hardware.nvidia.powerManagement.finegrained = true;

  # https://nixos.wiki/wiki/Nvidia#Installing_NVIDIA_official_drivers_on_NixOS
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver = {
    # https://nixos.wiki/wiki/Xorg
    # dpi = 168; # 96*1.75
    dpi = 144; # 96*1.5
    imwheel = {
      enable = true;
      rules = {
        # ".*" = ''
        "^(vieb|firefox|brave-browser|google-chrome-stable|google-chrome|telegram-desktop)$" = ''
          None, Up, Button4, 2
          None, Down, Button5, 2
          Shift_L,   Up,   Shift_L|Button4, 2
          Shift_L,   Down, Shift_L|Button5, 2
          Control_L, Up,   Control_L|Button4
          Control_L, Down, Control_L|Button5
        '';
      };
      # extraOptions = [ "--buttons=45" ]; # default
    };
  };
  services.xserver.screenSection = ''
    Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
    Option         "AllowIndirectGLXProtocol" "off"
    Option         "TripleBuffer" "on"
  '';

  networking.hostName = "pc";
  networking.hostId = "007f0200";
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.wlp6s0.useDHCP = true;
  networking.wireless.driver = "wext"; # "TP-Link TL-WN881 ND"
  networking.interfaces.wlp6s0.ipv4.addresses = [{
    address = "192.168.1.111";
    prefixLength = 24;
  }];
  networking.defaultGateway = "192.168.1.1";

  services.nginx.virtualHosts."live.fixasparts.com" = {
    forceSSL = true;
    enableACME = true;
    locations."/" = {
      proxyPass = "https://127.0.0.1:4173";
      proxyWebsockets = true;
      extraConfig = ''
      '';
    };

  };
}
