{ pkgs
, config
, ...
}: {
  # https://nixos.wiki/wiki/ACME
  security = {
    acme.acceptTerms = true;
    acme.defaults.email = "kalesnykas.aivaras@gmail.com";
    # acme.certs."domain.com" = {
    #   domain = "*.domain.com";
    #   extraDomainNames = ["*.domain.com"];
    #   dnsProvider = "rfc2136";
    #   credentialsFile = "/var/lib/secrets/certs.secret";
    #   # We don't need to wait for propagation since this is a local DNS server
    #   dnsPropagationCheck = false;
    # };
    acme = {
      # certs."test.ekolangas.lt" = {
      #   inherit (config.services.maddy) group;
      #   dnsProvider = "inwx";
      #   # Suplying password files like this will make your credentials world-readable
      #   # in the Nix store. This is for demonstration purpose only, do not use this in production.
      #   credentialsFile = "${pkgs.writeText "inwx-creds" ''
      #     INWX_USERNAME=xxxxxxxxxx
      #     INWX_PASSWORD=yyyyyyyyyy
      #   ''}";
      # };
    };
  };
}
