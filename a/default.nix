{ ... }:
{
  services.httpd.virtualHosts."dell.gettransfer.lt" = rec {
    # forceSSL = true;
    addSSL = true;
    sslServerKey = "/etc/nixos/a/cert.key";
    sslServerCert = "/etc/nixos/a/cert.pem";
    serverAliases = [ "a.local" ];
    documentRoot = "/etc/nixos/a";
    extraConfig = ''
      <Directory "${documentRoot}">
      	Options FollowSymlinks
      	AllowOverride All
      </Directory>
    '';
  };

}
