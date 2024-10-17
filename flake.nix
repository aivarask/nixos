{
  description = "NixOS config";
  inputs = {
    systems.url = "github:nix-systems/x86_64-linux";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-colors.url = "github:misterio77/nix-colors";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    LS_COLORS = {
      url = "github:trapd00r/LS_COLORS";
      flake = false;
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    vim-overlay.url = "path:/etc/nixos/overlays/vim";
    suckless.url = "path:/etc/nixos/overlays/suckless";
  };
  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-hardware,
      nix-colors,
      nix-on-droid,
      LS_COLORS,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      username = "root";
      include = (import ./config/.functions.nix).include;
      include_ = (import ./config/.functions.nix).include_;
      common = {
        imports = [
          inputs.suckless.nixosModules.default
        ] ++ include ./config ++ include ./config/systemd;
        nixpkgs.overlays = with inputs; [
          neovim-nightly-overlay.overlays.default
          nur.overlay
          rust-overlay.overlays.default
          vim-overlay.overlays.default
          suckless.overlays.default
          (import ./overlays/LS_COLORS.nix LS_COLORS)
          (import ./overlays/manix.nix { })
          (import ./overlays/gow.nix pkgs)
        ];
      };
      commonHome = {

        home.stateVersion = "23.05";
        home.username = username;
        home.enableNixpkgsReleaseCheck = false;
        manual.json.enable = true;
        nix.channels = {
          inherit nixpkgs;
          inherit home-manager;
        };
        colorScheme = nix-colors.colorSchemes.gruvbox-dark-medium;
        imports =
          [
            inputs.nix-index-database.hmModules.nix-index
            inputs.vim-overlay.home.default
            { programs.nix-index-database.comma.enable = true; }
            nix-colors.homeManagerModules.default
          ]
          ++ include_ ./config
          ++ include_ ./config/programs_
          ++ include ./c
          ++ include ./lua
          ++ include ./zsh;
        home.sessionVariables = {
          BROWSER = "firefox";
          MOZ_X11_EGL = "1";
        };
      };
      commonModules = include ./modules;
    in
    {
      formatter."${system}" = pkgs.nixfmt-rfc-style;
      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs { system = "aarch64-linux"; };
        modules = [ ./hosts/.redmi.nix ];
      };
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          # commonHome
          {
            home.stateVersion = "23.05";
            home.username = username;
            home.homeDirectory = "/root";
          }
        ];
        extraSpecialArgs = {
          inherit inputs system username;
        };
      };
      nixosConfigurations = {
        dell = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
          };
          modules = commonModules ++ [
            inputs.suckless.nixosModules.default
            common
            ./config/.dell.nix
            nixos-hardware.nixosModules.dell-xps-15-7590
            nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
            nixos-hardware.nixosModules.common-hidpi
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.root = commonHome;
              };
            }
          ];
        };
        pc = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
          };
          modules = commonModules ++ [
            inputs.suckless.nixosModules.default
            common
            ./config/.pc.nix
            nixos-hardware.nixosModules.common-cpu-amd-pstate
            nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
            nixos-hardware.nixosModules.common-hidpi
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.root = commonHome;
                # users.${username} = {

                # };
              };
            }
          ];
        };
      };
    };
}
