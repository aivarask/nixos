{ pkgs, config, ... }:
{
  # boot.kernelPackages = pkgs.linuxPackages_latest; # fails zfs
  boot.blacklistedKernelModules = [
  ];
  boot.kernelParams = [
    "boot.shell_on_fail"
    "loglevel=3" # ERROR
  ];
  boot.kernelModules = [
    "kvm-intel"
    "vhost_vsock"
  ];

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.disable_ipv6" = 1;
    "net.ipv6.conf.default.disable_ipv6" = 1;
  };
  boot.extraModulePackages = [ ];
  boot.initrd.kernelModules = [ ];
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "sd_mod"
    "rtsx_pci_sdmmc"
    "usb_storage"
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
  # For GeForce GTX 1650 nvidia.com recommends 550 version (stable), but 570 (beta) returns from suspend
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
}
