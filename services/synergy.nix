# https://wiki.archlinux.org/title/Deskflow
{ pkgs, ... }:
{
  nixpkgs.config.permittedInsecurePackages = [
    "deskflow-1.18.0"
  ];
  networking.firewall.allowedTCPPorts = [ 24800 ];
  environment.systemPackages = [
    # pkgs.quicksynergy
    # pkgs.synergy
    pkgs.deskflow
  ];
  services.synergy.server = {
    enable = false;
    configFile = ./synergy-server.conf;
  };
  services.synergy.client = {
    enable = false;
    serverAddress = "pcw"; # 24800 default port
  };
}
