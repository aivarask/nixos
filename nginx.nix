# https://nixos.wiki/wiki/Nginx
{ config, pkgs, lib, ... }: {

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
  services.nginx.virtualHosts = {
    "localhost" = {
      addSSL = false;
      enableACME = false;
      root = "/home/ak/deta.lt";
      locations."~ \.php$".extraConfig = ''
        fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
        fastcgi_index index.php;
      '';
      # extraConfig = ''
      #   auth_pam  "Password Required";
      #   auth_pam_service_name "nginx";
      # '';
    };
    # "dev.deta.lt" = {
    #   locations."~" = {
    #     proxyPass = "http://127.0.0.1:3000";
    #     proxyWebsockets = true;
    #   };
    # };
    "fix.deta.lt" = {
      locations."~" = {
        proxyPass = "http://127.0.0.1:3000";
        proxyWebsockets = true;
      };
    };
    # "chat.deta.lt" = {
    #   # TLS reverse proxy
    #   # enableACME = true;
    #   # forceSSL = true;
    #   locations."~" = {
    #     proxyPass = "http://127.0.0.1:3000";
    #     proxyWebsockets = true;
    #     # locations."~".proxyPass = "http://127.0.0.1:2022";
    #   };
    # };
    # "term.deta.lt" = {
    #   locations."~" = {
    #     proxyPass = "http://127.0.0.1:9999";
    #     # extraConfig = "rewrite ^/(.*) /wetty/$1 break;";
    #   };
    # };
  };
  services.phpfpm.pools.mypool = {
    user = "nobody";
    settings = {
      pm = "dynamic";
      "listen.owner" = config.services.nginx.user;
      "pm.max_children" = 5;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 1;
      "pm.max_spare_servers" = 3;
      "pm.max_requests" = 500;
    };
  };
}
