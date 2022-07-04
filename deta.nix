{ config, pkgs, lib, ... }:
let
  app = "mypool";
  domain = "${app}.deta.lt";
  dataDir = "/srv/http/${domain}";
in
{
  services.phpfpm.pools.${app} = {
    user = app;
    settings = {
      "listen.owner" = config.services.nginx.user;
      pm = "dynamic";
      "pm.max_children" = 5;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 1;
      "pm.max_spare_servers" = 3;
      "pm.max_requests" = 500;
    };
  };
  services.nginx.virtualHosts = {
    ${domain} = {
      addSSL = false;
      enableACME = false;
      root = dataDir;
      locations."~ \.php$".extraConfig = ''
        fastcgi_pass  unix:${config.services.phpfpm.pools.${app}.socket};
        fastcgi_index index.php;
      '';
    };
    # "dev.deta.lt" = {
    #   locations."~" = {
    # extraConfig = ''
    #   auth_pam  "Password Required";
    #   auth_pam_service_name "nginx";
    # '';
    #     proxyPass = "http://127.0.0.1:3000";
    #     proxyWebsockets = true;
    #   };
    # };
    # "fix.deta.lt" = {
    #   locations."~" = {
    #     proxyPass = "http://127.0.0.1:3000";
    #     proxyWebsockets = true;
    #   };
    # };
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
}

