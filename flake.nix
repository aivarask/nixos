{
  description = "NixOS config";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-master.url = "nixpkgs/master";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    LS_COLORS = {
      url = "github:trapd00r/LS_COLORS";
      flake = false;
    };
    nur.url = "github:nix-community/NUR";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    statix.url = "github:nerdypepper/statix";
    # devshell.url = "github:numtide/devshell";
    prisma = {
      url = "github:pimeys/nixos-prisma";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { self
    , nixpkgs
    , nixpkgs-master
    , flake-utils
    , home-manager
    , nur
    , statix
    , prisma
    , ...
    } @ inputs:
    let
      home = import ./home.nix;
      overlays = with inputs;[
        rust-overlay.overlays.default
        nur.overlay
        neovim-nightly-overlay.overlay
        statix.overlay
        prisma.overlay
        (final: prev: {
          dwm = prev.dwm.overrideAttrs (old: { src = ./overlays/dwm-flexipatch; });
          slstatus = prev.slstatus.overrideAttrs (old: { src = ./overlays/slstatus; });
          inherit LS_COLORS;
        })
      ];
      system = "x86_64-linux";
      inherit (nixpkgs) lib;
      eachDefaultEnvironment = f: flake-utils.lib.eachDefaultSystem
        (
          system:
          f {
            inherit system;
            pkgs = (import nixpkgs { inherit system; config.allowUnfree = true; }).extend self.overlay;
          }
        );
    in
    eachDefaultEnvironment
      ({ pkgs, system }: {
        #  devShell = import ./shell.nix ({ inherit pkgs; } // self.packages."${system}");
        packages = rec {
          inherit (pkgs.python3Packages) py-hello;
          # inherit pkgs.python3Packages.py-hello;
        };
        defaultPackage = self.packages."${system}".py-hello;
        # defaultPackage = py-hello;
      }) //
    {
      overlay = import ./overlay.nix self.inputs;
      checks = self.packages;
      nixosConfigurations.as = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          ./hosts/as.nix
          # ./misc/steam.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.root = home;
            home-manager.users.ak = home;
          }
          {
            nixpkgs.overlays = overlays;
          }
        ];
        # extraArgs = { inputs = inputs; };
      };
      nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          ./hosts/pc.nix
          ./steam.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.root = home;
            home-manager.users.ak = home;
          }
          {
            nixpkgs.overlays = overlays;
          }
        ];
        # extraArgs = { inputs = inputs; };
      };
      # legacyPackages.x86_64-linux =
      #   (builtins.head (builtins.attrValues self.nixosConfigurations)).pkgs;
    };
}
