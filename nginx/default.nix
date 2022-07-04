# https://nixos.wiki/wiki/Nginx
{ config, pkgs, lib, ... }: {
  imports = [
    # ./localhost.nix
    ./sandbox.nix
    ./example.nix
  ];

  services.nginx = {
    enable = true;
    additionalModules = [ pkgs.nginxModules.pam ];
    # TLS reverse proxy
    # recommendedProxySettings = true;
    # recommendedTlsSettings = true;
    # virtualHosts = {
    #   security.acme.certs."deta.lt".extraDomainNames = [ "chat.deta.lt" ];
    #   "chat.deta.lt" = {
    #     forceSSL = true;
    #     useACMEhost = "deta.lt";
    #   };
    # };
  };
}
