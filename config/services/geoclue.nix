{ lib, ... }:
{
  services.geoclue2 = {
    enable = lib.mkDefault true;
  };
}
