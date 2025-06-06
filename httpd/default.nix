{ lib, ... }:
{
  services.httpd.enable = true;
  services.httpd.enablePHP = true;
  services.httpd.logPerVirtualHost = false;
  services.httpd.logFormat = "common";
  services.httpd.extraModules = [
    "proxy_wstunnel"
  ];
  # systemd.services.httpd.serviceConfig.User = lib.mkForce "root";
  # services.httpd.user = "root";
  services.httpd.group = "wheel";
  services.httpd.virtualHosts."gettransfer" = rec {
    serverAliases = [
      "ge.lo"
      "gettransfer.local"
    ];
    documentRoot = "/etc/nixos/httpd";
    listen = [
      {
        ip = "*";
        port = 80;
      }
    ];
    extraConfig = "<Directory ${documentRoot}>\n  Options FollowSymlinks\n  AllowOverride All\n</Directory>\n";
  };
  systemd.tmpfiles.rules = [
    # "d /var/www/gettransfer.local"
    # "f /var/www/gettransfer.local/index.php - - - - <?php phpinfo();"
  ];
  # services.httpd.virtualHosts."aldale" = rec {
  #   serverAliases = [
  #     "a.lo"
  #     "aldale.local"
  #   ];
  #   documentRoot = "/var/www/aldale";
  #   listen = [
  #     {
  #       ip = "*";
  #       port = 80;
  #     }
  #   ];
  #   extraConfig = "<Directory ${documentRoot}>\n  Options FollowSymlinks\n  AllowOverride All\n</Directory>\n";
  # };
}
