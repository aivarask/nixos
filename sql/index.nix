{ ... }: {
  services.nginx.enable = true;
  services.nginx.virtualHosts."myhost.org" = {
    addSSL = true;
    enableACME = true;
    root = "/etc/nixos/sql";
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "foo@bar.com";
  };

}
