{ ... }: {
  services.unclutter = {
    enable = true;
    timeout = 1;
    extraOptions = [
      # "noevents"
      # "grab"
      # "fork"
    ];
  };
}
