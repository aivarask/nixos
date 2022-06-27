{ config, pkgs, lib, ... }: {
  security.sudo =
    {
      wheelNeedsPassword = false;
    };
  # https://nixos.org/manual/nixos/stable/#module-security-acme-nginx
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "kalesnykas.aivaras@gmail.com";
  security.pam.services.nginx.setEnvironment = false;
}
