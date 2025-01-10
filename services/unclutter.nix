{ pkgs, ... }:
{
  services.unclutter = {
    package = pkgs.unclutter-xfixes;
    enable = true;
    threshold = 1;
    timeout = 1;
    extraOptions = [
      # "noevents"
      # "grab"
      # "fork"
    ];
  };
}
