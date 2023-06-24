_: {
  # https://nixos.wiki/wiki/Nginx
  # https://nixos.org/manual/nixos/stable/#module-security-acme-nginx
  services.nginx.enable = true;
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
