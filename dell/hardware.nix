{ config, pkgs, ... }:
{
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
