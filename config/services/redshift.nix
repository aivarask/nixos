{ ... }: {
  services.redshift = {
    enable = true;
    temperature = {
      day = 6500; # 5500
      night = 4500; # 3700
    };
  };

}
