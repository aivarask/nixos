{ pkgs, ... }:
{
  environment.systemPackages = [
    # pkgs.quicksynergy
    pkgs.synergy
  ];
  services.synergy.server = {
    enable = true;
    configFile = ./synergy-server.conf;
  };
  services.synergy.client = {
    enable = true;
    serverAddress = "pcw"; # 24800 default port
  };
}
