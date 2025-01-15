arg: rec {
  documentRoot = arg;
  extraConfig = ''
    <Directory "${documentRoot}">
    	Options Indexes FollowSymlinks
    	AllowOverride All
    </Directory>
  '';
  # forceSSL = true;
  # addSSL = true;
  # sslServerKey = "cert.key";
  # sslServerCert = "cert.pem";
  # serverAliases = [ "" ];
}
