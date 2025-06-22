{ inputs, ... }:
inputs.disko.nixosModules.disko ./disko-config.nix {
  _module.args.disks = [ "/dev/sda" ];
}
