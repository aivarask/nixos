# vim: nofoldenable
{
  description = "NixOS config";
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";
    templates.url = "github:NixOS/templates";
    dev-templates.url = "https://flakehub.com/f/the-nix-way/dev-templates/0.1.283.tar.gz";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-colors.url = "github:misterio77/nix-colors";
    conky.url = "github:brndnmtthws/conky";
    firefox.url = "./firefox";
    go.url = "./go";
    hm.url = "./hm";
    lib.url = "./lib";
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
      commonModules = [
        inputs.lib.nixosModules.default
        inputs.LS_COLORS.nixosModules.default
        inputs.go.nixosModules.default
        inputs.manix.nixosModules.default
        inputs.matrix.nixosModules.default
        inputs.pistol.nixosModules.default
        inputs.rust.nixosModules.default
        inputs.suckless.nixosModules.default
        inputs.vim.nixosModules.default
        inputs.zsh.nixosModules.default
        {
          imports =
            with inputs.lib.packages."${system}".lib;
            (
              [ ]
              ++ i ./config
              ++ i ./config/systemd
              ++ i ./config/systemd/timers
              ++ idash ./config/systemd/services
              ++ i ./network
            );
        }

      ];
    in
    {
      devShell."${system}" = pkgs.mkShell { };
      formatter."${system}" = pkgs.nixfmt-rfc-style;
      nixosConfigurations.dell = nixpkgs.lib.nixosSystem {
        modules = commonModules ++ [
          inputs.nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
          ./dell.nix

        ];
        specialArgs = { inherit inputs; };
      };
      nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
        modules = [
          inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
          inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
          inputs.nixos-hardware.nixosModules.common-hidpi
          ./pc.nix
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
    };
}
