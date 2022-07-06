{ config, pkgs, lib, ... }: {
  systemd.services.nginx.serviceConfig.ReadWritePaths = [
    "/var/spool/nginx/logs/"
    "/var/www"
  ];
  services.nginx = {
    enable = true;
    virtualHosts = {
      "localhost" = {
        forceSSL = false;
        enableACME = false;
        # All serverAliases will be added as extra domain names on the certificate.
        # serverAliases = [ "bar.example.com" ];
        locations."/" = {
          root = "/var/www";
        };
      };
    };
  };

  # We can also add a different vhost and reuse the same certificate
  # but we have to append extraDomainNames manually.
  # security.acme.certs."foo.example.com".extraDomainNames = [ "baz.example.com" ];
  # "baz.example.com" = {
  #   forceSSL = true;
  #   useACMEHost = "foo.example.com";
  #   locations."/" = {
  #     root = "/var/www";
  #   };
  # };
}
