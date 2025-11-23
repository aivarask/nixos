{ config, ... }:
{
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
      "192.168.1.190" = {
        locations."/".proxyPass =
          "http://${config.services.nix-serve.bindAddress}:${toString config.services.nix-serve.port}";
      };
    };
  };
}
