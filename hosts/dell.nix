{ config, pkgs, lib, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  imports =
    [
      ./dell-hardware.nix
      ./common.nix
    ];
  # system.stateVersion = "23.?";
  console.font = "ter-i32b";

  environment.systemPackages = [ nvidia-offload ];
  services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.nvidia = { modesetting.enable = true; };
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.prime = {
    offload.enable = true;
    intelBusId = "PCI:0:2:0"; # lcpi
    nvidiaBusId = "PCI:1:0:0";
  };

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
  services.xserver.screenSection = ''
    Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
    Option         "AllowIndirectGLXProtocol" "off"
    Option         "TripleBuffer" "on"
  '';
  programs.light.enable = true; # not in use because of brightnessctl
  powerManagement.cpuFreqGovernor = "powersave";
  hardware.bluetooth.enable = false;
  services.blueman.enable = false;

  networking.hostName = "dell";
  networking.hostId = "8425e349";
  networking.useDHCP = false;
  networking.interfaces.wlp59s0.useDHCP = true;
  networking.interfaces.wlp59s0.ipv4.addresses = [{
    address = "192.168.1.112";
    prefixLength = 24;
  }];
  networking.defaultGateway = "192.168.1.1";

}
