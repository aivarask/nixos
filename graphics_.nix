{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pciutils
    mesa-demos
    gpu-viewer
    clinfo
    vulkan-tools
    libva-utils # vainfo
    intel-gpu-tools # intel_gpu_top
    nvtopPackages.nvidia # nvtop
  ];

}
