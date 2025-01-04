# vim: nofoldenable
{
  description = "NixOS config";
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";
    templates.url = "github:NixOS/templates";
    dev-templates.url = "https://flakehub.com/f/the-nix-way/dev-templates/0.1.283.tar.gz";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    conky.url = "github:brndnmtthws/conky";
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
    { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      commonModules = [
        inputs.lib.nixosModules.default
        inputs.LS_COLORS.nixosModules.default
        inputs.go.nixosModules.default
        inputs.hm.nixosModules.default
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
        modules = commonModules ++ [
          inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
          inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
          inputs.nixos-hardware.nixosModules.common-hidpi
          ./pc.nix
        ];
        specialArgs = { inherit inputs; };
      };
    };
}
