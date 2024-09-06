{ pkgs, ... }: {
  networking.hosts = { "127.0.0.1" = [ "music.local" ]; };
  networking.firewall.allowedTCPPorts = [ 3001 ];
  services.nginx.virtualHosts."music.local" = { locations."/" = { proxyPass = "http://localhost:3001"; }; };
  systemd.services.music = {
    enable = true;
    documentation = [ "https://github.com/vercel/serve" ];
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      User = "root";
      Group = "wheel";
      WorkingDirectory = "/var/music";
      ExecStart = "${pkgs.nodePackages.serve}/bin/serve -p 3001";
    };
  };
}
