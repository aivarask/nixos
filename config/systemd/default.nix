{ ... }: {
  systemd.network.enable = true;
  systemd = {
    sleep.extraConfig = ''
      HibernateDelaySec=1h
    '';
  };
}
