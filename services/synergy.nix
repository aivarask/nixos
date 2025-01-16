{ ... }:
{
  services.synergy.server = {
    enable = true;
  };
  services.synergy.client = {
    enable = true;
    serverAddress = "pcw"; # 24800 default port
  };
}
