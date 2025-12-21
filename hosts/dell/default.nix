{
  config,
  lib,
  modulesPath,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
    # inputs.nixos-hardware.nixosModules.common-gpu-intel-disable
    ./../../common/boot.nix
    ./../../lsp
    ./binarycache.nix
    ./bluetooth.nix
    ./boot.nix
    ./samba.nix
    ./network.nix
    ./storage.nix
    # ./virt.nix
  ];

  system.stateVersion = "23.05";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  services.switcherooControl.enable = true;

  # https://discourse.nixos.org/t/what-is-the-best-option-for-power-management/63406/6
  # https://wiki.nixos.org/wiki/Laptop
  # https://wiki.nixos.org/wiki/Power_Management
  services.thermald.enable = false;
  services.tlp.enable = false;
  services.tlp.settings = {
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    CPU_MIN_PERF_ON_AC = 0;
    CPU_MAX_PERF_ON_AC = 100;
    CPU_MIN_PERF_ON_BAT = 0;
    CPU_MAX_PERF_ON_BAT = 20;
    START_CHARGE_THRESH_BAT0 = 40;
    STOP_CHARGE_THRESH_BAT0 = 80;
  };
  services.auto-cpufreq.enable = false;
  services.auto-cpufreq.settings = {
    battery.governor = "powersave";
    battery.turbo = "never";
    charger.governor = "performance";
    charger.turbo = "auto";
  };
  # powerManagement.powertop.enable = true;

  environment.systemPackages = [
    pkgs.mesa-demos
    pkgs.gpu-viewer
    pkgs.vulkan-tools
  ];
  # services.xserver.videoDrivers = [ "modesetting" ];

  networking.firewall = {
    trustedInterfaces = [ "p2p-wl+" ];

    allowedTCPPorts = [
      7236
      7250
    ]; # wifi direct port ?
    allowedUDPPorts = [
      7236
      5353
    ];
  };
  xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      # pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-wlr
    ];

    xdgOpenUsePortal = true;
    config = {
      common = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.Screencast" = [ "hyprland" ];
      };
    };
    # config = {
    #   # common = {
    #   #   # "org.freedesktop.impl.portal.Screenshot" = "hyprland";
    #   #   "org.freedesktop.impl.portal.Screencast" = "hyprland";
    #   #   "org.freedesktop.portal.Screencast" = "hyprland";
    #   #   default = [ "hyprland" ];
    #   # };
    #   # hyprland.default = [
    #   #   "hyprland"
    #   #   "gtk"
    #   # ];
    # };
  };
}
