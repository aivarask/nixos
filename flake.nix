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
  inputs.zen-browser.url = "github:0xc000022070/zen-browser-flake";
  inputs.zen-browser.inputs.nixpkgs.follows = "nixpkgs";
  inputs.zen-browser.inputs.home-manager.follows = "home-manager";
  inputs.niri-session-manager.url = "github:MTeaHead/niri-session-manager";
  inputs.nirinit.url = "github:amaanq/nirinit";
  inputs.nirinit.inputs.nixpkgs.follows = "nixpkgs";
  outputs =
    { nixpkgs, self, ... }@inputs:
    let
      SELF = "/etc/nixos";
      xdgconf = "${SELF}/.config";
      commonModules = [
        inputs.nirinit.nixosModules.nirinit
        {
          services.nirinit = {
            enable = true;
            settings.skip.apps = [ "steam" ];
            settings.launch."chromium-example.com__-Default" = "example-web-app";

          };
        }
        # inputs.niri-session-manager.nixosModules.niri-session-manager
        {
          # services.niri-session-manager.enable = true;
          # services.niri-session-manager.package = {
          #   save-interval = 1;
          #   max-backup-count = 3;
          # };
          # --save-interval <MINUTES>     How often to save the session (default: 15)
          # --max-backup-count <COUNT>    Number of backup files to keep (default: 5)
          # --spawn-timeout <SECONDS>     How long to wait for windows to spawn (default: 5)
          # --retry-attempts <COUNT>      Number of restore attempts (default: 3)
          # --retry-delay <SECONDS>       Delay between retry attempts (default: 2)
        }

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
            ];
            users.root = {
              home.username = "root";
              home.homeDirectory = "/root";
              imports = [
                inputs.nix-colors.homeManagerModules.default
                inputs.zen-browser.homeModules.twilight
                ./.programs.nix
                ./vim.nix
              ];
            };
          };
        }
        # inputs.disko.nixosModules.disko
        ./.config/mopidy/default.nix
        ./.config/mpd/default.nix
        ./.config/pipewire/default.nix
        ./environment.nix
        ./httpd
        ./vimlua.nix
        ./modules/torrents.nix
        ./nix.nix
        ./services.nix
        ./niri.nix
        ./modules/autologin.nix
        ./modules/boot.nix
        # ./modules/fileSystems.nix
        ./modules/gnome.nix
        ./modules/graphics.nix
        ./modules/search.nix
        ./modules/searx.nix
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
          ./network.nix
          ./dell.nix
          # ./hdmi-cec.nix
          ./modules/steam.nix
        ];
      };
      nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs self xdgconf; };
        modules = commonModules ++ [
          ./modules/pihole.nix
          ./minimal.nix
          ./network.nix
          ./pc.nix
          # ./modules/steam.nix
        ];
      };
    });
}
