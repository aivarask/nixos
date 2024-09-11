{ ... }:
{
  security.acme = {
    acceptTerms = true;
    defaults.email = "kalesnykas.aivaras@gmail.com";
  };
  security.acme.defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";
}
