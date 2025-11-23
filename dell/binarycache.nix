{ config, ... }:
{
  nix.settings.substituters = [
    "http://192.168.1.190"
  ];
  services.nix-serve = {
    enable = true;
    secretKeyFile = "/var/cache-priv-key.pem";
  };
  networking.firewall.allowedTCPPorts = [
    80
  ];
  services.nginx = {

    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "binarycache.dell.local" = {
        locations."/".proxyPass =
          "http://${config.services.nix-serve.bindAddress}:${toString config.services.nix-serve.port}";
      };
    };
  };
}
