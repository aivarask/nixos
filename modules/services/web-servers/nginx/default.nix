{config, ...}: {
  # https://nixos.wiki/wiki/Nginx
  # https://nixos.org/manual/nixos/stable/#module-security-acme-nginx
  # ../../networking/nix-serve.nix
  services.nginx = {
    enable = false;
    recommendedProxySettings = true;
    # virtualHosts = {
    #   "binarycache.example.com" = {
    #     locations."/".proxyPass = "http://${config.services.nix-serve.bindAddress}:${toString config.services.nix-serve.port}";
    #   };
    # };
  };
  # services.nginx.virtualHosts = {
  #   "domain.com" = {
  #     forceSSL = true;
  #     enableACME = true;
  #     # All serverAliases will be added as extra domain names on the certificate.
  #     serverAliases = ["test.domain.com"];
  #     locations."/" = {
  #       root = "/var/www";
  #     };
  #   };
  # };
}
