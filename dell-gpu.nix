{ pkgs, ... }:
{

  # /run/opengl-driver/lib/dri
  environment.variables.LIBVA_DRIVER_NAME = "nvidia";
  # /run/opengl-driver/lib/vdpau
  environment.variables.VDPAU_DRIVER = "nvidia";
  # stat /dev/dri/*
  environment.variables.MOZ_DRM_DEVICE = "/dev/dri/by-path/pci-0000:01:00.0-card";
  # environment.variables.LIBVA_DRIVER_NAME = "nvidia";
  # environment.variables.VDPAU_DRIVER = "nvidia";
  environment.variables.VAAPI_DEVICE = "/dev/dri/by-path/pci-0000:01:00.0-card";
  environment.variables.MOZ_DISABLE_RDD_SANDBOX = 1;
  environment.variables.NVD_BACKEND = "direct";
  # (https://unix.stackexchange.com/a/596888)
  # https://wiki.archlinux.org/title/HiDPI#GDK_3_(GTK_3)

  environment.systemPackages = with pkgs; [
    kmscon
    #
    lshw
    mesa-demos # glxinfo glxgears
    libva-utils # vainfo
    intel-gpu-tools # intel_gpu_top
    nvtopPackages.nvidia # nvtop
    nvtopPackages.intel
    vdpauinfo # vdpauinfo
    libvdpau
    libvdpau-va-gl
    vulkan-tools # vulkaninfo
    clinfo # clinfo
  ];
  services.kmscon = {
    hwRender = false;
    # font-dpi=${toString config.services.xserver.dpi}
    # font-size=${if config.networking.hostName == "dell" then "10" else "12"}
    # https://github.com/dvdhrm/kmscon/issues/143
    # https://discourse.nixos.org/t/services-kmscon-keyboard-repeat-rate/48619
    # https://www.reddit.com/r/linux/comments/oaaps/whats_the_default_keyboard_repeat_rate_in_an/
    # kbdrate -r 30 -d 250
    extraConfig = ''
      			no-drm
      		'';

  };
}
