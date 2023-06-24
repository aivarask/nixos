_: {
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
  };
}
