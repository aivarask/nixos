{ config, ... }: {
  location = {
    # provider = "geoclue2";
    provider = "manual";
    latitude = 54.0;
    longitude = 25.0;
  };
}
