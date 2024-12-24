{
  description = "NixOS tests example";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    {
      nixosModules = {
        helloNixosModule = import ./hello-module.nix;
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlay = final: prev: {
          helloNixosTests = self.packages.${system}.helloNixosTests;
        };
        pkgs = nixpkgs.legacyPackages.${system}.extend overlay;
      in
      {
        checks = {
          helloNixosTest = pkgs.callPackage ./hello-boots.nix { inherit self; };
        };
        packages = {
          helloNixosTests = pkgs.writeScriptBin "hello-nixos-tests" ''
            ${pkgs.netcat}/bin/nc -l 3000
          '';
        };
      }
    );
}
