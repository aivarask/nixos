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
    ./binarycache.nix
    ./bluetooth.nix
    ../common/boot.nix
    ./boot.nix
    ./kmscon.nix
    ./network.nix
    ./qt.nix
    ./storage.nix
    # ./virt.nix
    ../lsp
  ];

  system.stateVersion = "23.05";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  services.switcherooControl.enable = true;
  services.xserver.dpi = 283;

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

    # Optional helps save long term battery health
    START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
    STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
  };
  services.auto-cpufreq.enable = false;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
  powerManagement.powertop.enable = true;

  specialisation.nvidia.configuration = {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.graphics.enable = true;
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    hardware.nvidia.modesetting.enable = true;
    hardware.nvidia.prime.sync.enable = false;
    hardware.nvidia.prime.nvidiaBusId = "PCI:1:0:0"; # lspci
    hardware.nvidia.prime.intelBusId = "PCI:0:2:0"; # lspci
  };

}
