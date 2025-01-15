{ ... }:
{
  services.httpd = {
    enable = true;
    user = "root";
    group = "root";
    logPerVirtualHost = false;
    logFormat = "common";
    extraModules = [
      "proxy_wstunnel"
    ];
    extraConfig = '''';
  };
  # services.httpd.virtualHosts."localhost" = import ./httpd_vh.nix;
}
