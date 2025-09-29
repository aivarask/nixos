# https://wiki.archlinux.org/title/Deskflow
{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.deskflow
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "deskflow-1.19.0"
    "libsoup-2.74.3"
  ];
  networking.firewall.allowedTCPPorts = [ 24800 ];
}
