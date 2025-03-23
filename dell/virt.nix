{ ... }:
{
  programs.virt-manager.enable = true;
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
