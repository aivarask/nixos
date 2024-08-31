{ config, lib, pkgs, ... }:
{
  imports = [ ./options/sshd.nix ./sshd.nix ];
  environment.packages = with pkgs; [
    vim
    git
    htop
    hostname
    nmap
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
        programs.bash = {
          initExtra = ''
            sshd-start
          '';
        };
        programs.lf = {
          enable = true;
          settings = {
            hidden = true;
          };
        };
      };
  };

}
