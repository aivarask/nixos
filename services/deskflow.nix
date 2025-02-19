# https://wiki.archlinux.org/title/Deskflow
{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.deskflow
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "deskflow-1.19.0"
  ];
  networking.firewall.allowedTCPPorts = [ 24800 ];
}
