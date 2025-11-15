{ ... }:
{
  services.redshift = {
    enable = false;
    temperature.day = 6500;
    temperature.night = 5500;
  };
}
