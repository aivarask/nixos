_: {
  imports =
    map (n: "${./timers}/${n}") (builtins.attrNames (builtins.readDir ./timers))
    ++ map (n: "${./services}/${n}") (builtins.attrNames (builtins.readDir ./services));

  systemd = {
    sleep.extraConfig = ''
      HibernateDelaySec=1h
    '';
    services = {
    };
  };
}
