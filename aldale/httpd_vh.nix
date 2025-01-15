rec {
  documentRoot = "${./.}";
  extraConfig = ''
    <Directory "${documentRoot}">
    	Options FollowSymlinks
    	AllowOverride All
    </Directory>
  '';
  # forceSSL = true;
  # addSSL = true;
  # sslServerKey = "cert.key";
  # sslServerCert = "cert.pem";
  # serverAliases = [ "" ];
}
