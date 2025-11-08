# B450 AORUS M
{
  config,
  lib,
  modulesPath,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../common/boot.nix
    ./boot.nix
    ./network.nix
    ./storage.nix
    ../lsp

    # inputs.disko.nixosModules.disko
    # ./disko-config.nix
    # { _module.args.disks = [ "/dev/sda" ]; }

    (
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        environment.systemPackages = with pkgs; [
          grim # screenshot functionality
          slurp # screenshot functionality
          wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
          mako # notification system developed by swaywm maintainer
        ];

        # Enable the gnome-keyring secrets vault.
        # Will be exposed through DBus to programs willing to store secrets.
        services.gnome.gnome-keyring.enable = true;

        # enable Sway window manager
        programs.sway = {
          enable = true;
          wrapperFeatures.gtk = true;
        };
      }
    )
  ];
  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.fancontrol.enable = false;
  hardware.fancontrol.config = '''';

}
