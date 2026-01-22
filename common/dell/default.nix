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
    ./../../lsp
    ./../boot.nix
    ./../xdg.nix
    ./bluetooth.nix
    ./boot.nix
    # ./network.nix
  ];
  system.stateVersion = "26.05";
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

}
