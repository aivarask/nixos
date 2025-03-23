{ ... }:
{
  programs.virt-manager.enable = true;
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
  };
  users.users.nixosvmtest.isSystemUser = true;
  users.users.nixosvmtest.initialPassword = "test";
  users.users.nixosvmtest.group = "nixosvmtest";
  users.groups.nixosvmtest = { };
  virtualisation.vmVariant = {
    # nixos-rebuild build-vm
    virtualisation = {
      memorySize = 2048;
      cores = 3;
    };
  };
}
