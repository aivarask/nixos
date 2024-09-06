{ pkgs, ... }: {
  systemd.services.serve-music = {
    enable = true;
    # description = "serve /var/music";
    # documentation = "https://pm2.keymetrics.io/";
    after = [ "network.target" ];
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      User = "root";
      Group = "wheel";
      WorkingDirectory = "/var/music";
      ExecStart = "${pkgs.nodePackages.serve}/bin/serve -p 3001";
    };
    wantedBy = [ "multi-user.target" ];
  };
  networking.firewall.allowedTCPPorts = [ 3001 ];
}
