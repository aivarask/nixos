{ ... }:
{
  systemd.services.nix-daemon.environment = {
    https_proxy = "socks5h://localhost:7891";
  };
  systemd.network.enable = true;
  systemd = {
    sleep.extraConfig = ''
      HibernateDelaySec=1h
    '';
  };
}
