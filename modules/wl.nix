{ pkgs, config, ... }:
{
  boot.kernelModules = [
    "wl"
  ];
  boot.extraModulePackages = [
    config.boot.kernelPackages.broadcom_sta
  ];
  boot.initrd.kernelModules = [ "wl" ];
  nixpkgs.config.permittedInsecurePackages = [
    # "broadcom-sta-6.30.223.271-59-6.18.17"
  ];
}
