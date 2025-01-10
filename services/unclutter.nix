{ pkgs, ... }:
{
  environment.systemPackages = [
    # pkgs.unclutter
    # pkgs.xorg.libX11
  ];
  services.xbanish = {
    enable = true;
    arguments = "";
  };
  # services.unclutter = {
  #   package = pkgs.unclutter-xfixes;
  #   enable = true;
  #   threshold = 1;
  #   timeout = 1;
  #   extraOptions = [
  #     # "noevents"
  #     # "grab"
  #     # "fork"
  #   ];
  # };
}
