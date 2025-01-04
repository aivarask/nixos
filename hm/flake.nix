# vim: nofoldenable
{
  inputs = {
    nixpkgs.url = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    firefox.url = "./firefox";
    lib.url = "./lib";
    zsh.url = "./zsh";
  };
  outputs =
    { ... }@inputs:
    let
      system = "x86_64-linux";
      commonHome = {
        home.stateVersion = "23.05";
        home.username = "root";
        home.homeDirectory = "/root";
        home.enableNixpkgsReleaseCheck = false;
        manual.json.enable = true;
        colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
        imports =
          with inputs.lib.packages."${system}".lib;
          (
            [
              inputs.nix-index-database.hmModules.nix-index
              inputs.zsh.hmModules.default
              inputs.firefox.nixosModules.home
              inputs.nix-colors.homeManagerModules.default
            ]
            ++ i_ ./config
            ++ i ./config/programs_
            ++ i_ ./lua
          );
      };
    in
    {
      nixosModules.default = inputs.home-manager.nixosModules.home-manager {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.root = commonHome;
        };
      };
    };
}
