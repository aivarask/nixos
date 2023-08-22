{pkgs, ...}: {
  systemd.services.serve-music = {
    enable = true;
    description = "serve /var/music";
    # documentation = "https://pm2.keymetrics.io/";
    after = ["network.target"];
    serviceConfig = {
      Type = "simple";
      User = "root";
      Group = "wheel";
      ExecStart = "${pkgs.nodePackages.serve}/bin/serve";
      ExecReload = "${pkgs.nodePackages.serve}/bin/serve";
      Restart = "on-failure";
      StartLimitBurst = 2;
      StartLimitInterval = 10;

      RuntimeDirectory = "/var/music";
      RootDirectory = "/var/music";
    };
    wantedBy = ["multi-user.target"];
  };
}
