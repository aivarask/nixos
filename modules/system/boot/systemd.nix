{
  pkgs,
  lib,
  ...
}: {
  imports = [./timers/hello-world.nix];
  systemd = {
    sleep.extraConfig = ''
      HibernateDelaySec=1h
    '';

    timers."slstatus" = {
      enable = false;
      wantedBy = ["timers.target"];
      timerConfig = {
        OnActiveSec = "3";
        # OnBootSec = "10";
        # OnStartupSec = "5";
        OnUnitActiveSec = "1h";
        Unit = "slstatus.service";
        Persistent = true;
      };
    };

    services = {
      dnscrypt-proxy2.serviceConfig = {
        StateDirectory = "dnscrypt-proxy";
      };
      "slstatus" = {
        script = ''
          set -eu
          ${pkgs.dig}/bin/dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com > /tmp/ip
          # ${pkgs.dig}/bin/dig +short myip.opendns.com @resolver1.opendns.com > /tmp/ip
          ${pkgs.curl}/bin/curl -s wttr.in/Vilnius?format=2 > /tmp/wttr
        '';
        serviceConfig = {
          Type = "oneshot";
          User = "root";
        };
      };

      nginx.serviceConfig = {
        SupplementaryGroups = ["shadow"];
        NoNewPrivileges = lib.mkForce false;
        PrivateDevices = lib.mkForce false;
        ProtectHostname = lib.mkForce false;
        ProtectKernelTunables = lib.mkForce false;
        ProtectKernelModules = lib.mkForce false;
        RestrictAddressFamilies = lib.mkForce [];
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

      pm2 = {
        enable = false;
        description = "PM2 process manager";
        # documentation = "https://pm2.keymetrics.io/";
        after = ["network.target"];
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
        wantedBy = ["multi-user.target"];
      };
    };
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
