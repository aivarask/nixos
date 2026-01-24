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
    ./../../lsp
    ./../boot.nix
    ./../binarycache.nix
    ./../network/networking.nix
    # ./../network/wireless.nix
    ./boot.nix
    # ./network.nix
    ./storage.nix
    ./../../minimal.nix
  ];
  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.fancontrol.enable = false;
  hardware.fancontrol.config = '''';

}
