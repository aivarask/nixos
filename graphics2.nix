# https://discourse.nixos.org/t/suspend-issue-on-prime-nvidia-intel/74005
{ pkgs, lib, ... }:
{
  services.graphical-desktop.enable = lib.mkDefault true;

  ######################
  # Video acceleration #
  ######################
  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

  hardware.graphics.extraPackages = with pkgs; [
    # Yes, you only need this, I don't know why the internet
    # insists on adding all those other packages here, they
    # either do nothing or they actively break vaapi
    intel-media-driver
  ];

  ##################
  #  Using nvidia  #
  ##################

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = true;

    powerManagement = {
      enable = true;
      finegrained = true;
    };

    # Note that these settings don't do *anything* if you're using wayland.
    # If you *are* using wayland you can just delete all of this; whatever
    # your primary GPU is will always be your primary GPU, assuming
    # your firmware doesn't change its mind about which GPU to default
    # to - if you want control over that, see my answer to this other post:
    #
    # https://discourse.nixos.org/t/why-nixos-using-dgpu-instead-of-igpu/73973/2?u=tlater
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";

      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };
}
