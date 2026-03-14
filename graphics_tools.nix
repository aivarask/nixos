{ pkgs, config, ... }:

{
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.nvidia.open = true;
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
  environment.systemPackages = with pkgs; [
    pciutils
    mesa-demos
    gpu-viewer
    clinfo
    vulkan-tools
    libva-utils # vainfo
    intel-gpu-tools # intel_gpu_top
    nvtopPackages.nvidia # nvtop
    # ffmpeg-full
    ((pkgs.ffmpeg-full.override { withUnfree = true; }).overrideAttrs (_: {
      doCheck = false;
    }))
  ];
}
