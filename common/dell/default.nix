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
    inputs.nixos-hardware.nixosModules.dell-xps-15-7590-nvidia # https://github.com/NixOS/nixos-hardware/tree/master/dell/xps/15-7590
    # https://wiki.nixos.org/wiki/Linux_kernel#Configuration
    ./../xdg.nix
    ./../../lsp
    ./binarycache.nix
    ./bluetooth.nix
    ./../boot.nix
    ./boot.nix
    ./network.nix
    ./storage.nix
    # (
    #   { ... }:
    #   {
    #     programs.virt-manager.enable = true;
    #     users.users.nixosvmtest.isSystemUser = true;
    #     users.users.nixosvmtest.initialPassword = "test";
    #     users.users.nixosvmtest.group = "nixosvmtest";
    #     users.groups.nixosvmtest = { };
    #     virtualisation.vmVariant = {
    #       # nixos-rebuild build-vm
    #       virtualisation = {
    #         memorySize = 2048;
    #         cores = 3;
    #       };
    #     };
    #   }
    # )
  ];

  system.stateVersion = "23.05";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  services.switcherooControl.enable = true;

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
  powerManagement.powertop.enable = false;

  # hardware.nvidia.prime.allowExternalGpu = true;
  # hardware.nvidia.prime.reverseSync.enable = true;

  # hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  boot.kernelParams = [
    # "module_blacklist=i915"
  ];
}
