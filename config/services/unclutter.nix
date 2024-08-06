{ ... }: {
  services.unclutter = {
    enable = false;
    timeout = 1;
    extraOptions = [
      # "noevents"
      # "grab"
      # "fork"
    ];
  };
}
