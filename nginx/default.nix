# https://nixos.org/manual/nixos/stable/#module-security-acme-nginx
_: {
  security = {
    acme.acceptTerms = true;
  };
  security.acme.defaults.email = "kalesnykas.aivaras@gmail.com";
  security.pam.services.nginx.setEnvironment = false;

  services.nginx.enable = true;
}
