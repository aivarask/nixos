{ pkgs, ... }: {
  systemd.services."pm2-example" = {
    enable = false;
    description = "PM2 process manager";
    # documentation = "https://pm2.keymetrics.io/";
    after = [ "network.target" ];
    serviceConfig = {
      Type = "forking";
      User = "root";
      Group = "wheel";
      LimitNOFILE = "infinity";
      LimitNPROC = "infinity";
      LimitCORE = "infinity";
      Environment = "PM2_HOME=/root/.pm2";
      PIDFile = "/root/.pm2/pm2.pid";
      Restart = "on-failure";
      ExecStart = "${pkgs.nodePackages.pm2}/bin/pm2 resurrect";
      ExecReload = "${pkgs.nodePackages.pm2}/bin/pm2 reload all";
      ExecStop = "${pkgs.nodePackages.pm2}/bin/pm2 kill";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
