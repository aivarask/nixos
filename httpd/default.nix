{ ... }:
{
  services.httpd.enable = true;
  services.httpd.enablePHP = true;
  services.httpd.logPerVirtualHost = false;
  services.httpd.logFormat = "common";
  services.httpd.extraModules = [
    "proxy_wstunnel"
  ];

  services.httpd.virtualHosts."gettransfer.lt" = rec {
    documentRoot = "/etc/nixos/httpd";
    serverAliases = [ "get.l" ];
    listen = [
      {
        ip = "*";
        port = 8080;
      }
    ];
    extraConfig = "<Directory ${documentRoot}>\n  Options FollowSymlinks\n  AllowOverride All\n</Directory>\n";
  };
  systemd.tmpfiles.rules = [
    # "d /var/www/gettransfer.local"
    # "f /var/www/gettransfer.local/index.php - - - - <?php phpinfo();"
  ];

}
