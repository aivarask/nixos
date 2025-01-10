{ pkgs, ... }:
{
  networking.hosts = {
    "127.0.0.1" = [ "video.local" ];
  };
  networking.firewall.allowedTCPPorts = [ 3002 ];
  services.nginx.virtualHosts."video.local" = {
    locations."/" = {
      proxyPass = "http://localhost:3002";
    };
  };
  systemd.services.video = {
    enable = true;
    documentation = [ "https://github.com/vercel/serve" ];
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      User = "root";
      Group = "wheel";
      WorkingDirectory = "/var/lib/transmission/Downloads";
      ExecStart = "${pkgs.nodePackages.serve}/bin/serve -p 3002";
    };
  };
}
