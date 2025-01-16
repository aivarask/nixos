{ pkgs, ... }:
{
  environment.systemPackages = [
    # pkgs.quicksynergy
    pkgs.synergy
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
