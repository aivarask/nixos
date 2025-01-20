{ ... }:
{
  services.httpd = {
    enable = true;
    # user = "root";
    # group = "root";
    logPerVirtualHost = false;
    logFormat = "common";
    extraModules = [
      "proxy_wstunnel"
    ];
    extraConfig = ''
      			<IfModule "mod_proxy_http.c">
            	ProxyPass "/ws/" "https://echo.websocket.org/" upgrade=websocket
            </IfModule>

            		'';
  };
}
