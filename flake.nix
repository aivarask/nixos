{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-parts.url = "github:hercules-ci/flake-parts";
  inputs.systems.url = "github:nix-systems/x86_64-linux";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-utils.inputs.systems.follows = "systems";

  inputs.disko.url = "github:nix-community/disko/latest";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";
  inputs.home-manager.url = "github:nix-community/home-manager"; # https://github.com/nix-community/home-manager
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nix-colors.url = "github:misterio77/nix-colors";
  inputs.nix-index-database.url = "github:nix-community/nix-index-database";
  inputs.nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nur.url = "github:nix-community/NUR";
  inputs.nur.inputs.nixpkgs.follows = "nixpkgs";
  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  inputs.neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";
  inputs.musnix.url = "github:musnix/musnix";
  #
  inputs.smart-semicolon.url = "github:iagotito/smart-semicolon.nvim";
  inputs.smart-semicolon.flake = false;
  outputs =
    { nixpkgs, self, ... }@inputs:
    let
      SELF = "/etc/nixos";
      xdgconf = "${SELF}/.config";
      commonModules = [
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            backupFileExtension = "backup";
            useGlobalPkgs = true;
            useUserPackages = true;
            verbose = true;
            extraSpecialArgs = {
              inherit inputs;
              inherit SELF;
              inherit xdgconf;
            };
            sharedModules = [ { home.stateVersion = "26.05"; } ];

            users.root = {
              home.username = "root";
              home.homeDirectory = "/root";
              home.enableNixpkgsReleaseCheck = false;
              manual.json.enable = true;
              programs.man.generateCaches = true;
              colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
              imports = [
                inputs.nix-colors.homeManagerModules.default
                ./.programs.nix
                ./lua/default_hm.nix
              ];
            };
          };
        }
        inputs.disko.nixosModules.disko
        ./.config/mpd/default.nix
        ./.config/pipewire/default.nix
        ./modules/torrents.nix
        ./disks.nix
        ./environment.nix
        ./packages.nix
        ./nix.nix
        ./services.nix
        ./httpd
        ./lua
        ./sway
      ];
    in
    inputs.flake-utils.lib.eachDefaultSystem (system: {
      # checks./*<SYSTEM>.*/"<CHECK>" = /* ... */;
      # devShells./*<SYSTEM>.*/"<DEV_SHELL>" = /* ... */;
      # packages./*<SYSTEM>.*/"<PACKAGE>" = /* ... */;
    })
    // inputs.flake-utils.lib.eachDefaultSystemPassThrough (system: {
      formatter."${system}" = nixpkgs.legacyPackages."${system}".nixfmt-tree;
      nixpkgs.hostPlatform = system;
      packages."${system}" = { };

      nixosConfigurations.iso-minimal = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs self xdgconf; };
        modules = [
          ./modules/iso.nix
          ./minimal.nix
        ];
      };
      nixosConfigurations.minimal = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs self xdgconf; };
        modules = commonModules ++ [
          (
            {
              modulesPath,
              lib,
              config,
              ...
            }:
            {
              networking.hostName = "minimal";
              system.stateVersion = "26.05";
              nixpkgs.hostPlatform = system; # lib.mkDefault "x86_64-linux";

              imports = [
                (modulesPath + "/installer/scan/not-detected.nix")
                (modulesPath + "/installer/cd-dvd/latest-kernel.nix")
                # inputs.disko.nixosModules.disko
                ./modules/autologin.nix
                ./modules/graphics.nix
                ./modules/bluetooth.nix
                ./boot.nix
                ./dell.nix
                ./minimal.nix
                ./mix.nix
                ./network.nix
                ./search.nix
              ];

            }
          )
        ];
      };
      nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
        modules = commonModules ++ [
          ./modules/autologin.nix
          ./modules/graphics.nix
          ./boot.nix
          ./minimal.nix
          ./network.nix
          ./pc.nix
          ./search.nix
        ];
        specialArgs = { inherit inputs self xdgconf; };
      };
    });
}
