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
  outputs =
    { nixpkgs, self, ... }@inputs:
    let
      SELF = "/etc/nixos";
      xdgconf = "${SELF}/.config";
      commonModules = [

        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            startAsUserService = false;
            backupFileExtension = "backup";
            useGlobalPkgs = true;
            useUserPackages = true;
            verbose = true;
            extraSpecialArgs = { inherit inputs SELF xdgconf; };
            sharedModules = [
              {
                home.stateVersion = "26.05";
                home.enableNixpkgsReleaseCheck = false;
              }
              inputs.nix-colors.homeManagerModules.default
            ];
            users.root.home.username = "root";
            users.roo.home.homeDirectory = "/root";
          };
        }
        # ./modules/fileSystems.nix
        # inputs.disko.nixosModules.disko
        ./.config/bat/default.nix
        ./.config/chromium/default.nix
        ./.config/direnv/default.nix
        ./.config/eza/default.nix
        ./.config/fzf/default.nix
        ./.config/git/default.nix
        ./.config/mopidy/default.nix
        ./.config/mpd/default.nix
        ./.config/mpv/default.nix
        ./.config/ncmpcpp/default.nix
        ./.config/nicotine/default.nix
        ./.config/pipewire/default.nix
        ./.config/ripgrep/default.nix
        ./.config/starship/default.nix
        ./.config/zsh/default.nix
        ./modules/.programs.nix
        ./modules/environment.nix
        ./firefox/default.nix
        ./httpd
        ./modules/autologin.nix
        ./modules/boot.nix
        ./modules/gnome.nix
        ./modules/graphics.nix
        ./modules/search.nix
        ./modules/searx.nix
        ./modules/torrents.nix
        ./modules/niri.nix
        ./modules/nix.nix
        ./modules/services.nix
        ./modules/vim.nix
        ./modulesvimlua.nix
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
        specialArgs = { inherit inputs self xdgconf; };
        modules = commonModules ++ [
          ./modules/bluetooth.nix
          ./modules/pihole.nix
          ./minimal.nix
          ./modules/network.nix
          ./dell.nix
          # ./hdmi-cec.nix
          # ./modules/steam.nix
        ];
      };
      nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs self xdgconf; };
        modules = commonModules ++ [
          ./modules/pihole.nix
          ./minimal.nix
          ./modules/network.nix
          ./pc.nix
          # ./modules/steam.nix
        ];
      };
    });
}
