{
  description = "NixOS config";
  inputs = {
    systems.url = "github:nix-systems/x86_64-linux";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      include =
        p:
        with builtins;
        map (f: "${p}/${f}") (filter (n: !isNull (match ".*+\.nix" n)) (attrNames (readDir p)));
      common = {
        imports =
          [
            inputs.suckless.nixosModules.default
          ]
          ++ include ./config
          ++ include ./config/programs
          ++ include ./config/services
          ++ include ./config/systemd;
        nixpkgs.overlays = with inputs; [
          suckless.overlays.default
          vim-overlay.overlays.default
          rust-overlay.overlays.default
          nur.overlay
          (import ./overlays/LS_COLORS.nix LS_COLORS)
          neovim-nightly-overlay.overlays.default
          # (import ./overlays/suckless.nix inputs)
          (import ./overlays/manix.nix)
          (final: prev: {
            gow = pkgs.buildGoModule {
              name = "gow";
              src = builtins.fetchGit {
                url = "https://github.com/mitranim/gow";
                rev = "af11a6e1e9ebccdcdace2a6df619355b85494d74";
              };
              vendorHash = "sha256-Xw9V7bYaSfu5kA2505wmef2Ns/Y0RHKbZHUkvCtVNSM=";
            };
          })
        ];
        nix.registry = {
          os = {
            to = {
              type = "git";
              url = "file:///etc/nixos";
            };
          };
          "dev-templates" = {
            to = {
              owner = "the-nix-way";
              repo = "dev-templates";
              type = "github";
            };
          };
        };
      };
      commonHome = {
        home.stateVersion = "23.05";
        home.enableNixpkgsReleaseCheck = false;
        manual.json.enable = true;
        nix.channels = {
          inherit nixpkgs;
          inherit home-manager;
        };
        colorScheme = nix-colors.colorSchemes.gruvbox-dark-medium;
        imports = [
          inputs.vim-overlay.home.default
          nix-colors.homeManagerModules.default
        ] ++ include ./home ++ include ./home/programs ++ include ./home/services;
        home.shellAliases = { };
        home.sessionVariables = {
          BROWSER = "firefox";
          MOZ_X11_EGL = "1";
        };
        home.file = { };
      };
      commonModules = include ./modules ++ include ./lua;
    in
    {
      formatter."${system}" = pkgs.nixfmt-rfc-style;
      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs { system = "aarch64-linux"; };
        modules = [ ./hosts/redmi.nix ];
      };
      nixosConfigurations = {
        dell = nixpkgs.lib.nixosSystem {
          # DELL XPS 7590
          inherit system;
          modules = commonModules ++ [
            inputs.suckless.nixosModules.default
            common
            ./hosts/dell.nix
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
          # PC B450 AORUS M
          inherit system;
          modules = commonModules ++ [
            common
            ./hosts/pc.nix
            nixos-hardware.nixosModules.common-cpu-amd-pstate
            nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
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
      };
    };
}
