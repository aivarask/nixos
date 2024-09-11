{ lib, ... }:
{
  location = {
    # provider = lib.mkDefault "geoclue2"; # manual
    provider = lib.mkDefault "manual";
    latitude = 54.0;
    longitude = 25.0;
  };
}
