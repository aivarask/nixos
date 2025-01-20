config: {
  networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "ve-+" ];
  networking.nat.externalInterface =
    {
      dell = "wlp59s0";
      pc = "wlp6s0";
    }
    ."${config.networking.hostName}";
}
