{ ... }:
{
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=1h
  '';
}
