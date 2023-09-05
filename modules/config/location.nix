{lib, ...}: {
  location = {
    # provider = lib.mkDefault "geoclue2"; # manual
    provider = "manual";
    latitude = 54.0;
    longitude = 25.0;
  };
}
