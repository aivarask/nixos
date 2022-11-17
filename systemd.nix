{ config, pkgs, lib, ... }: {

  systemd.services.nginx.serviceConfig = {
    SupplementaryGroups = [ "shadow" ];
    NoNewPrivileges = lib.mkForce false;
    PrivateDevices = lib.mkForce false;
    ProtectHostname = lib.mkForce false;
    ProtectKernelTunables = lib.mkForce false;
    ProtectKernelModules = lib.mkForce false;
    RestrictAddressFamilies = lib.mkForce [ ];
    LockPersonality = lib.mkForce false;
    MemoryDenyWriteExecute = lib.mkForce false;
    RestrictRealtime = lib.mkForce false;
    RestrictSUIDSGID = lib.mkForce false;
    SystemCallArchitectures = lib.mkForce "";
    ProtectClock = lib.mkForce false;
    ProtectKernelLogs = lib.mkForce false;
    RestrictNamespaces = lib.mkForce false;
    SystemCallFilter = lib.mkForce "";
  };

  systemd.services.pm2 = {
    enable = true;
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


  # systemd.services.serve = {
  #   enable = true;
  #   description = "Serve music";
  #   # documentation = "https://pm2.keymetrics.io/";
  #   after = [ "network.target" ];
  #   serviceConfig = {
  #     Type = "forking";
  #     User = "root";
  #     Group = "wheel";
  #     LimitNOFILE = "infinity";
  #     LimitNPROC = "infinity";
  #     LimitCORE = "infinity";
  #     # Environment = "PM2_HOME=/root/.pm2";
  #     # PIDFile = "/root/.pm2/pm2.pid";
  #     Restart = "on-failure";
  #     ExecStart = "${pkgs.nodePackages.serve}/bin/serve";
  #     ExecReload = "${pkgs.nodePackages.serve}/bin/serve";
  #     ExecStop = "${pkgs.nodePackages.serve}/bin/serve";

  #     RuntimeDirectory = "music";
  #     RootDirectory = "/etc/nixos/music";
  #   };
  #   wantedBy = [ "multi-user.target" ];
  # };
}
