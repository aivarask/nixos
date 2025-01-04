{
  inputs = {
    nixpkgs.url = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    { ... }@inputs:
    {
      nixosModules.default = inputs.home-manager.nixosModules.home-manager {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          # users.root = commonHome;
        };
      };
    };
}
