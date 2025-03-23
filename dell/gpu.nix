{ pkgs, config, ... }:
{

  # environment.variables.LIBVA_DRIVER_NAME = "nvidia"; # nvidia nouveau /run/opengl-driver/lib/dri
  # environment.variables.VDPAU_DRIVER = "nouveau"; # /run/opengl-driver/lib/vdpau
  # environment.variables.MOZ_DRM_DEVICE = "/dev/dri/by-path/pci-0000:01:00.0-card"; # stat /dev/dri/*
  # environment.variables.VAAPI_DEVICE = "/dev/dri/by-path/pci-0000:01:00.0-card";
  # environment.variables.MOZ_DISABLE_RDD_SANDBOX = 1;
  # environment.variables.NVD_BACKEND = "direct"; # direct (default) or egl
  # (https://unix.stackexchange.com/a/596888)
  # https://wiki.archlinux.org/title/HiDPI#GDK_3_(GTK_3)

  qt = {
    # environment.variables.GTK_THEME = "Adwaita:dark";
    # environment.sessionVariables.QT_STYLE_OVERRIDE = "adwaita-dark";
    enable = true;
    # platformTheme = "kde";
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # https://github.com/elFarto/nvidia-vaapi-driver
  boot.kernelModules = [
    # "nvidia_drm"
  ];
  boot.kernelParams = [
    # "nvidia-drm.modeset=1"
  ];
  environment.systemPackages = with pkgs; [
    # lshw
    # mesa-demos # glxinfo glxgears
    # nvidia-vaapi-driver
    libva-utils # vainfo
    intel-gpu-tools # intel_gpu_top
    nvtopPackages.nvidia # nvtop
    nvtopPackages.intel
    # vdpauinfo # vdpauinfo
    # libvdpau
    # libvdpau-va-gl
    # vulkan-tools # vulkaninfo
    # clinfo # clinfo
  ];
  services.kmscon = {
    hwRender = true;
    # font-size=${if config.networking.hostName == "dell" then "10" else "12"}
    # https://github.com/dvdhrm/kmscon/issues/143
    # https://discourse.nixos.org/t/services-kmscon-keyboard-repeat-rate/48619
    # https://www.reddit.com/r/linux/comments/oaaps/whats_the_default_keyboard_repeat_rate_in_an/
    # https://ubuntuhandbook.org/index.php/2021/08/enable-hardware-video-acceleration-va-api-for-firefox-in-ubuntu-20-04-18-04-higher/
    # kbdrate -d 250 -r 50
    extraConfig = ''
      font-dpi=${toString config.services.xserver.dpi}
      # no-drm
    '';
  };
  services.xserver.dpi = 283;
}
