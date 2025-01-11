{ pkgs, ... }:
{
  # services.xbanish.enable = true;
  services.unclutter-xfixes = {
    # package = pkgs.unclutter-xfixes;
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
