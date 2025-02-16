{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.bitwarden
    # pkgs.bitwarden-cli
    pkgs.bitwarden-desktop
  ];

}
