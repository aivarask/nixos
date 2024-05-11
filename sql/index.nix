# https://nixos.wiki/wiki/Nginx
{ ... }: {
  networking.hosts = { };
  services.nginx.enable = true;
  services.nginx = {
    recommendedProxySettings = true;
  };
  services.nginx.virtualHosts."localhost.local" = {
    # addSSL = true;
    # enableACME = true;
    root = "/etc/nixos/sql";
    # locations."~ ^(.+\.php)(.*)$" = { };
    # locations."~ \\.php$".extraConfig = ''
    # fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
    # fastcgi_index index.php;
    # '';
  };
  services.nginx.virtualHosts."rust.localhost.local" = {
    # addSSL = true;
    # enableACME = true;
    root = "/etc/nixos/sql";
  };
  services.nginx.virtualHosts."music.localhost.local" = {
    locations."/" = {
      proxyPass = "http://localhost:3001";
    };
  };
}
