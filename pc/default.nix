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
    ../lsp

    # inputs.disko.nixosModules.disko
    # ./disko-config.nix
    # { _module.args.disks = [ "/dev/sda" ]; }

    (import ../sway).system
  ];
  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.fancontrol.enable = false;
  hardware.fancontrol.config = '''';

}
