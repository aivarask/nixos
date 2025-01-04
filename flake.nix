# vim: nofoldenable
{
  description = "NixOS config";
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";
    templates.url = "github:NixOS/templates";
    dev-templates.url = "https://flakehub.com/f/the-nix-way/dev-templates/0.1.283.tar.gz";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-colors.url = "github:misterio77/nix-colors";
    conky.url = "github:brndnmtthws/conky";
    firefox.url = "./firefox";
    go.url = "./go";
    LS_COLORS.url = "./LS_COLORS";
    manix.url = "./manix";
    matrix.url = "./matrix";
    suckless.url = "./suckless";
    pistol.url = "./pistol";
    rust.url = "./rust";
    vim.url = "./vim";
    wayland.url = "./wayland";
    zsh.url = "./zsh";
    # https://nix-community.github.io/haumea
  };
  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-hardware,
      nix-colors,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      username = "root";
      f = import ./func.nix;
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
            # inputs.vim-overlay.home.default
            inputs.zsh.hmModules.default
            inputs.firefox.nixosModules.home
            nix-colors.homeManagerModules.default
          ]
          ++ f.i_ ./config
          ++ f.i ./config/programs_
          ++ f.i_ ./lua;
      };
      common = {
        imports =
          f.i ./config
          ++ f.i ./config/systemd
          ++ f.i ./config/systemd/timers
          ++ f.idash ./config/systemd/services
          ++ f.i ./network;
      };
    in
    {
      devShell."${system}" = pkgs.mkShell { };
      formatter."${system}" = pkgs.nixfmt-rfc-style;
      nixosConfigurations.dell = nixpkgs.lib.nixosSystem {
        modules = [
          nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
          inputs.LS_COLORS.nixosModules.default
          inputs.go.nixosModules.default
          inputs.manix.nixosModules.default
          inputs.matrix.nixosModules.default
          inputs.pistol.nixosModules.default
          inputs.rust.nixosModules.default
          inputs.suckless.nixosModules.default
          inputs.vim.nixosModules.default
          inputs.zsh.nixosModules.default
          common
          ./hosts/dell.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.root = commonHome;
            };
          }
        ];
        specialArgs = { inherit inputs; };
      };
      nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
        # B450 AORUS M
        inherit system;
        specialArgs = { inherit inputs; };
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
}
