# B450 AORUS M
{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../common/boot.nix
    ./network.nix
    ./storage.nix
    ./pc.route.nix
  ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    fancontrol = {
      enable = false;
      config = '''';
    };
  };
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    # powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  system.stateVersion = "23.05";
  environment.variables.LIBVA_DRIVER_NAME = "vdpau";
  environment.systemPackages = with pkgs; [ libva-utils ];
  services.xserver.dpi = builtins.ceil (90 * 2.5);
}
