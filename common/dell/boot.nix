{ pkgs, config, ... }:
{
  # hardware.nvidia.prime.allowExternalGpu = true;
  # hardware.nvidia.prime.reverseSync.enable = true;
  # hardware.nvidia.modesetting.enable = true;
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;

  # https://wiki.nixos.org/wiki/Linux_kernel#Configuration
  boot.blacklistedKernelModules = [
    # "cirrusfb"
    # "i2c_piix4"
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelPackages = pkgs.linuxPackages_6_12;
  boot.kernelModules = [
    "kvm-intel"
    "vhost_vsock"
    "i2c-dev"
  ];
  boot.kernelParams = [
    "boot.shell_on_fail"
    "loglevel=3"
    # "module_blacklist=i915"
    # "nvidia-drm.fbdev=1"
  ];
  boot.extraModprobeConfig = builtins.concatStringsSep "\n" [
    "options dell-smm-hwmon ignore_dmi=1"
  ];
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.disable_ipv6" = 1;
    "net.ipv6.conf.default.disable_ipv6" = 1;
  };
  boot.initrd.availableKernelModules = [
    "rtsx_pci_sdmmc"
    "usb_storage"
  ];

}
