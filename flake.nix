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
  outputs =
    { nixpkgs, self, ... }@inputs:
    let
      commonModules = [
        inputs.home-manager.nixosModules.home-manager
        inputs.disko.nixosModules.disko
        ./modules/home-manager.nix
        ./modules/users_root.nix
        # ./modules/fileSystems.nix
        # inputs.disko.nixosModules.disko
        ./modules/bat/default.nix
        ./modules/chromium/default.nix
        ./modules/direnv/default.nix
        ./modules/eza/default.nix
        ./modules/fzf/default.nix
        ./modules/git/default.nix
        # ./modules/irc.nix
        # ./modules/mopidy/default.nix
        ./modules/mpd/default.nix
        ./modules/mpv/default.nix
        ./modules/ncmpcpp/default.nix
        ./modules/nicotine/default.nix
        ./modules/pipewire/default.nix
        ./modules/ripgrep/default.nix
        ./modules/starship/default.nix
        ./modules/zsh/default.nix
        ./modules/.programs.nix
        ./modules/environment.nix
        ./firefox/default.nix
        ./modules/httpd/default.nix
        ./modules/autologin.nix
        ./modules/boot.nix
        ./modules/graphics.nix
        ./modules/search.nix
        ./modules/searx.nix
        ./modules/torrents.nix
        ./modules/niri.nix
        ./modules/nix.nix
        ./modules/services.nix
        ./modules/vim.nix
        ./modules/vimlua.nix
      ];
      commonSpecialArgs = rec {
        inherit inputs self;
        SELF = "/etc/nixos";
        xdgconf = "${SELF}/.config";
      };
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

      nixosConfigurations.iso-min = nixpkgs.lib.nixosSystem {
        # nix build .\#nixosConfigurations.iso-min.config.system.build.isoImage
        # nixos-rebuild build-image --image-variant iso --flake .\#iso-min && qemu-system-x86_64 -enable-kvm -m 10240 -cdrom result/iso/nixos-*.iso
        modules = [
          ({ modulesPath, ... }: {
            imports = [
              (modulesPath + "/installer/cd-dvd/iso-image.nix")
              (modulesPath + "/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix")
            ];
          })
        ];

      };
      nixosConfigurations.iso-image = nixpkgs.lib.nixosSystem {
        # nixos-rebuild build-image --image-variant iso --flake .\#iso-image && qemu-system-x86_64 -enable-kvm -m 10240 -cdrom result/iso/nixos-*.iso
        specialArgs = commonSpecialArgs;
        modules = commonModules ++ [
          ./modules/minimal.nix
          ({ modulesPath, ... }: {
            imports = [ (modulesPath + "/installer/cd-dvd/iso-image.nix") ];
          })
        ];
      };
      nixosConfigurations.base = nixpkgs.lib.nixosSystem {
        specialArgs = commonSpecialArgs;
        modules =commonModules ++ [ 
          ./disko-udisk.nix
          { disko.devices.disk.udisk.device = nixpkgs.lib.mkForce "/dev/sda"; }
        ];
      };
      nixosConfigurations.minimal = nixpkgs.lib.nixosSystem {
        specialArgs = commonSpecialArgs;
        modules = commonModules ++ [
          ./modules/minimal.nix
          ./modules/network.nix
          ./modules/dnsmasq.nix
          ./modules/bluetooth.nix
          ./modules/dell.nix
          ({ modulesPath, ... }: {
            isoImage.compressImage = false;
            imports = [ 
              (modulesPath + "/installer/cd-dvd/iso-image.nix") 
              # (modulesPath + "/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix")
            ];
          })
        ];
      };

      nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = commonSpecialArgs;
        modules = commonModules ++ [
          ./modules/minimal.nix
          ./modules/dnsmasq.nix
          ./modules/network.nix
          ./modules/pc.nix
        ];
      };
    });
}
