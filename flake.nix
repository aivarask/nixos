{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-parts.url = "github:hercules-ci/flake-parts";
  inputs.systems.url = "github:nix-systems/x86_64-linux";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-utils.inputs.systems.follows = "systems";
  inputs.disko.url = "github:nix-community/disko/latest";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.mozid.url = "github:tupakkatapa/mozid";
  inputs.nix-colors.url = "github:misterio77/nix-colors";
  inputs.nix-index-database.url = "github:nix-community/nix-index-database";
  inputs.nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nur.url = "github:nix-community/NUR";
  inputs.nur.inputs.nixpkgs.follows = "nixpkgs";
  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  inputs.neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";
  inputs.niri-session-manager.url = "github:MTeaHead/niri-session-manager";
  inputs.nirinit.url = "github:amaanq/nirinit";
  inputs.nirinit.inputs.nixpkgs.follows = "nixpkgs";
  inputs.ableton.url = "github:shibco/ableton-linux";
  inputs.ableton.inputs.nixpkgs.follows = "nixpkgs";
  # https://pyproject-nix.gitaivaraskt.nix/use-cases/pyproject.html
  # inputs.pyproject-nix.inputs.nixpkgs.follows = "nixpkgs";
  # https://github.com/MatteoGuadrini/mkpl
  # inputs.mkpl.url = "github:aivarask/mkpl";
  # inputs.mkpl.inputs.nixpkgs.follows = "nixpkgs";

  outputs =
    inputs@{ flake-parts, ... }:
    # https://flake.parts/module-arguments.html
    flake-parts.lib.mkFlake { inherit inputs; } (
      top@{
        config,
        withSystem,
        moduleWithSystem,
        ...
      }:
      {
        imports = [
          inputs.home-manager.nixosModules.home-manager
        ];
        flake = {
          # Put your original flake attributes here.
          nixosConfigurations.iso-min = inputs.nixpkgs.lib.nixosSystem {
            # nixos-rebuild build-image --image-variant iso --flake .\#iso-min && qemu-system-x86_64 -enable-kvm -m 10240 -cdrom result/iso/nixos-*.iso
            # inherit system;
            modules = [
              ({ modulesPath, ... }: {
                imports = [
                  (modulesPath + "/installer/cd-dvd/iso-image.nix")
                  (modulesPath + "/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix")
                ];
              })
            ];

          };
        };
        systems = [
          "x86_64-linux"
        ];
        perSystem = { config, pkgs, ... }: {
          # Recommended: move all package definitions here.
          # e.g. (assuming you have a nixpkgs input)
          # packages.foo = pkgs.callPackage ./foo/package.nix { };
          # packages.bar = pkgs.callPackage ./bar/package.nix {
          #   foo = config.packages.foo;
          # };
        };
      }
    );
}
