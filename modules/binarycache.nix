{ config, ... }:
{
  services.nix-serve.enable = true;
  services.nix-serve.secretKeyFile = "/var/cache-priv-key.pem";
  networking.firewall.allowedTCPPorts = [
    80
  ];
  services.nginx.enable = true;
  services.nginx.recommendedProxySettings = true;
  services.nginx.virtualHosts."${config.networking.hostName}".locations."/".proxyPass =
    "http://${config.services.nix-serve.bindAddress}:${toString config.services.nix-serve.port}";

}
