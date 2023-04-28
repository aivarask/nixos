_: {
  services.redshift = {
    enable = true;
    temperature = {
      day = 6500; # 5500
      night = 4500; # 3700
    };
    latitude = 54.0;
    longitude = 25.0;
    provider = "manual";
  };
}
