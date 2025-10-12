{ pkgs, config, ... }:
let
  port = config.services.nginx.defaultHTTPListenPort;
in
{
  networking.hosts = {
    "127.0.0.1" = [ "music.local" ];
  };
  networking.firewall.allowedTCPPorts = [ 3001 ];
  services.nginx.virtualHosts."music.local" = {
    locations."/" = {
      proxyPass = "http://localhost:3001";
    };
  };
  systemd.services.music = {
    enable = false;
    documentation = [ "https://github.com/vercel/serve" ];
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      User = "root";
      Group = "wheel";
      WorkingDirectory = "/var/lib/mpd/music";
      ExecStart = "${pkgs.nodePackages.serve}/bin/serve -l tcp://192.168.1.195:3001";
    };
  };
}
