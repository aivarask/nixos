{ pkgs, ... }:
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
  imports = [
    ./_networking.nix
    ./dell-hardware.nix
  ];
  system.stateVersion = "23.05";
  console.font = "ter-i32b";

  environment.systemPackages = [ nvidia-offload ];

  services = {
    xserver.videoDrivers = [ "nvidia" ];
    xserver = {
      # https://nixos.wiki/wiki/Xorg
      dpi = 168; # 96*1.75
      # dpi = 144; # 96*1.5
      # dpi = 120; # 96*1.25
      libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
      };
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

  networking = {
    hostName = "dell";
    hostId = "8425e349";
    useDHCP = false;
    interfaces.wlp59s0.useDHCP = true;
    interfaces.wlp59s0.ipv4.addresses = [
      {
        address = "192.168.1.112";
        prefixLength = 24;
      }
    ];
    defaultGateway = "192.168.1.1";
  };
}
