{ config, ... }:
{
  # specialisation.nvidia.configuration = {
  #   # services.xserver.videoDrivers = [
  #   #   # "nvidia"
  #   #   "modesetting"
  #   # ];
  #   # hardware.graphics.enable = true;
  #   # environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
  #   # # hardware.graphics.extraPackages = with pkgs; [
  #   #   intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
  #   #   intel-vaapi-driver # For older processors. LIBVA_DRIVER_NAME=i965
  #   # ];
  #   # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  #   # hardware.nvidia.modesetting.enable = true;
  #   # hardware.nvidia.prime.sync.enable = false;
  #   # hardware.nvidia.prime.nvidiaBusId = "PCI:1:0:0"; # lspci
  #   # hardware.nvidia.prime.intelBusId = "PCI:0:2:0"; # lspci
  # };
}
