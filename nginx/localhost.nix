{ config, pkgs, lib, ... }: {
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
  services.nginx.virtualHosts = {
    "localhost" = {
      addSSL = false;
      enableACME = false;
      root = "/etc/nixos/deta.lt";
      locations."~ \.php$".extraConfig = ''
        fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
        fastcgi_index index.php;
      '';
    };
    # "chat.deta.lt" = {
    #   # TLS reverse proxy
    #   # enableACME = true;
    #   # forceSSL = true;
    #   locations."~" = {
    #     proxyPass = "http://127.0.0.1:3000";
    #     proxyWebsockets = true;
    #     # locations."~".proxyPass = "http://127.0.0.1:2022";
    #     # extraConfig = "rewrite ^/(.*) /wetty/$1 break;";
    #   };
    # extraConfig = ''
    #   auth_pam  "Password Required";
    #   auth_pam_service_name "nginx";
    # '';
    # };
  };

}

