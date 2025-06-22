# B450 AORUS M
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
    ../common/boot.nix
    ./boot.nix
    ./network.nix
    ./storage.nix

    # inputs.disko.nixosModules.disko
    # ./disko-config.nix
    # { _module.args.disks = [ "/dev/sda" ]; }

  ];
  system.stateVersion = "23.05";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.fancontrol.enable = false;
  hardware.fancontrol.config = '''';

}
