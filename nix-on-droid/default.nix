{ config, lib, pkgs, ... }:
{
  environment.packages = with pkgs; [
    vim git htop hostname nmap
  ];

  environment.etcBackupExtension = ".bak";
  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  home-manager = {
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;
    config =
      { config, lib, pkgs, ... }:
      {
        home.stateVersion = "24.05";
      };
  };

}
