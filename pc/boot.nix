{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    # inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    # inputs.nixos-hardware.nixosModules.common-gpu-nvidia-sync
    # inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
    # inputs.nixos-hardware.nixosModules.common-hidpi
  ];
  boot.kernelModules = [
    "kvm-amd"
    "vhost_vsock"
  ];
  boot.kernelParams = [
    "boot.shell_on_fail"
    "loglevel=3"
  ];

  # boot.kernel.sysctl = {
  #   # Enable IP forwarding
  #   "net.ipv4.ip_forward" = 1;
  #   "net.ipv6.conf.all.disable_ipv6" = 1;
  #   "net.ipv6.conf.default.disable_ipv6" = 1;
  #   # controls whether packets traversing a Linux bridge will be passed through iptables' FORWARD chain. When set to 1 (enabled), it allows iptables rules to affect bridged (as opposed to just routed) traffic.
  #   "net.bridge.bridge-nf-call-iptables" = 1;
  #   "net.ipv4.conf.all.forwarding" = 1;
  #   "hardware.graphics.enable32Bitnet.ipv6.conf.all.forwarding" = 1;
  #   "net.ipv4.conf.all.proxy_arp" = 1;
  #   "net.ipv4.conf.ens2.proxy_arp" = 1;
  # };

  boot.blacklistedKernelModules = [ ];
  boot.kernelPackages = pkgs.linuxPackages_6_1;
  # boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  # boot.initrd.kernelModules = [ "nvidia" ];
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.open = true;
  hardware.graphics.enable = true;
  hardware.nvidia.modesetting.enable = true;
  # hardware.nvidia.powerManagement.enable = true;
  # hardware.nvidia.powerManagement.finegrained = true;
  hardware.nvidia.nvidiaSettings = true;

  # environment.variables.LIBVA_DRIVER_NAME = "vdpau";
  environment.systemPackages = with pkgs; [
    # nvtopPackages.nvidia # nvtop
    # libva-utils
  ];
  services.xserver.videoDrivers = [
    "nvidia"
    # "modesetting"
  ];
}
