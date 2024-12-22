# vim:nofoldenable
{
  description = "NixOS config";
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";
    nixvirt.url = "https://flakehub.com/f/AshleyYakeley/NixVirt/0.5.0.tar.gz";
    nixvirt.inputs.nixpkgs.follows = "nixpkgs";
    dev-templates.url = "https://flakehub.com/f/the-nix-way/dev-templates/0.1.283.tar.gz";
    systems.url = "github:nix-systems/x86_64-linux";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-on-droid.url = "github:nix-community/nix-on-droid/release-24.05";
    nix-on-droid.inputs.nixpkgs.follows = "nixpkgs";
    nix-on-droid.inputs.home-manager.follows = "home-manager";
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-colors.url = "github:misterio77/nix-colors";
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    LS_COLORS.url = "github:trapd00r/LS_COLORS";
    LS_COLORS.flake = false;
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    vim-overlay.url = "path:/etc/nixos/overlays/vim";
    suckless.url = "path:/etc/nixos/overlays/suckless";
    conky.url = "github:brndnmtthws/conky";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland"; # Prevents version mismatch.
    };
    # https://nix-community.github.io/haumea/intro/getting-started.html
  };
  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-hardware,
      nix-colors,
      nix-on-droid,
      LS_COLORS,
      nixvirt,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      username = "root";
      f = import ./func.nix;
      common = {
        imports =
          [ inputs.suckless.nixosModules.default ]
          ++ f.i ./config
          ++ f.i ./config/systemd
          ++ f.i ./config/systemd/timers
          ++ f.idash ./config/systemd/services
          ++ f.i ./network;
        nixpkgs.overlays = with inputs; [
          neovim-nightly-overlay.overlays.default
          nur.overlays.default
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
        home.homeDirectory = "/root";
        home.enableNixpkgsReleaseCheck = false;
        manual.json.enable = true;
        colorScheme = nix-colors.colorSchemes.gruvbox-dark-medium;
        imports =
          [
            inputs.nix-index-database.hmModules.nix-index
            inputs.vim-overlay.home.default
            nix-colors.homeManagerModules.default
          ]
          ++ f.i_ ./config
          ++ f.i ./config/programs_
          ++ f.i_ ./lua;
      };
    in
    {
      formatter."${system}" = pkgs.nixfmt-rfc-style;
      devShell."${system}" = pkgs.mkShell { };
      homeConfigurations.default = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs system username; };
        modules = [ commonHome ];
      };
      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs { system = "aarch64-linux"; };
        modules = [ ./hosts/.redmi.nix ];
      };
      nixosConfigurations = {
        dell = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            nixvirt.nixosModules.default
            inputs.suckless.nixosModules.default
            common
            ./config/.dell.nix
            nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
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
          # B450 AORUS M
          inherit system;
          specialArgs = {
            inherit inputs;
          };
          modules = [
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
              };
            }
          ];
        };
      };
    };
}
