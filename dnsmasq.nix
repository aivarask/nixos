{
  pkgs,
  config,
  lib,
  ...
}:
{
  services.dnsmasq.enable = true;
  services.dnsmasq.resolveLocalQueries = false;
  environment.etc."dnsmasq.conf".source = "/etc/nixos/dnsmasq.conf";
  systemd.services.dnsmasq =
    let
      stateDir = "/var/lib/dnsmasq";
      configFile = "/etc/dnsmasq.conf";
      dnsmasq = config.services.dnsmasq.package;
    in
    {
      # server=/linkomanija.net/1.1.1.1
      # https://oneuptime.com/blog/post/2026-01-15-setup-dnsmasq-local-dns-ubuntu/view
      # https://github.com/imp/dnsmasq/blob/master/dnsmasq.conf.example
      preStart = lib.mkForce ''
        mkdir -m 755 -p ${stateDir}
        touch ${stateDir}/dnsmasq.leases
        chown -R dnsmasq ${stateDir}
        dnsmasq --test -C ${configFile}
      '';
      serviceConfig = lib.mkForce {
        Type = "dbus";
        BusName = "uk.org.thekelleys.dnsmasq";
        # BusName = "lt.org.aivarask.dnsmasq";
        ExecStart = "${dnsmasq}/bin/dnsmasq -k --enable-dbus --user=dnsmasq -C ${configFile}";
        ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
        PrivateTmp = true;
        ProtectSystem = true;
        ProtectHome = true;
        Restart = "on-failure"; # "always"
      };
      restartTriggers = lib.mkForce [
        config.environment.etc.hosts.source
        config.environment.etc."dnsmasq.conf".source
      ];
    };
}
