{ pkgs, ... }:
{
  # imports = [ ./options/sshd.nix ./sshd.nix ];
  # imports = [ ./sss.nix ];
  environment.packages = with pkgs; [
    utillinux
    which
    vim
    git
    htop
    hostname
    nmap
    openssh
    man
    gnugrep
    gnupg
    gnused
    gnutar
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
            # sshd-start
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
