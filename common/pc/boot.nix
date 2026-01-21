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
    "i2c-dev"
    "ddcci-backlight"

  ];
  boot.kernelParams = [
    "boot.shell_on_fail"
    "loglevel=3"
  ];

  services.udev.extraRules =
    # udevadm
    let
      bash = "${pkgs.bash}/bin/bash";
      # cat /sys/bus/i2c/devices/i2c-17/name
      # ddcutil setvcp 10 70
      ddcciDev = "nvkm-0000:06:00.0-aux-0009";
      ddcciNode = "/sys/bus/i2c/devices/i2c-17/new_device";
    in
    ''
      SUBSYSTEM=="i2c", ACTION=="add", ATTR{name}=="${ddcciDev}", RUN+="${bash} -c 'sleep 30; printf ddcci\ 0x37 > ${ddcciNode}'"
    '';

  # boot.kernel.sysctl = {
  #   "net.ipv4.ip_forward" = 1;
  #   "net.ipv6.conf.all.disable_ipv6" = 1;
  #   "net.ipv6.conf.default.disable_ipv6" = 1;
  #   "net.bridge.bridge-nf-call-iptables" = 1; # controls whether packets traversing a Linux bridge will be passed through iptables' FORWARD chain. When set to 1 (enabled), it allows iptables rules to affect bridged (as opposed to just routed) traffic.
  #   "net.ipv4.conf.all.forwarding" = 1;
  #   "hardware.graphics.enable32Bitnet.ipv6.conf.all.forwarding" = 1;
  #   "net.ipv4.conf.all.proxy_arp" = 1;
  #   "net.ipv4.conf.ens2.proxy_arp" = 1;
  # };

  boot.blacklistedKernelModules = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelPackages = pkgs.linuxPackages_6_1;
  boot.extraModulePackages = [ config.boot.kernelPackages.ddcci-driver ];
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

}
