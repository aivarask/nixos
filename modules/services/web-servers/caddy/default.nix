{...}: {
  # https://caddyserver.com/docs/caddyfile/options#http-port
  # https://mynixos.com/nixpkgs/options/services.caddy
  services.caddy = {
    enable = false;
    # extraConfig = ''
    # http_port = 8080
    # '';
    virtualHosts."localhost".extraConfig = ''
      respond "Hello, world!"
    '';
  };
}
