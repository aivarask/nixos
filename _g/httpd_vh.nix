path: rec {
  documentRoot = path;
  extraConfig = ''
        <Directory "${documentRoot}">
        	Options Indexes FollowSymlinks
        	AllowOverride All
    			DirectoryIndex index.html index.php
        </Directory>
  '';
  # forceSSL = true;
  # addSSL = true;
  # sslServerKey = "cert.key";
  # sslServerCert = "cert.pem";
  # serverAliases = [ "" ];
}
