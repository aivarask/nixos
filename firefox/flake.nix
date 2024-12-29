# vim: nofoldenable
{
  description = "firefox";
  inputs = {
    nixpkgs.url = "nixpkgs";
    systems.url = "systems";
    firefox-nightly.url = "github:nix-community/flake-firefox-nightly";
    firefox-nightly.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    {
      self,
      nixpkgs,
      systems,
      firefox-nightly,
    }:
    let
      forEachSupportedSystem =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f {
            pkgs = import nixpkgs { inherit system; };
          }
        );
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              cachix
              lorri
              niv
              nixfmt-classic
              statix
              vulnix
              haskellPackages.dhall-nix
            ];
          };
        }
      );

      nixosModules.default = (import ./. { inherit firefox-nightly; });
    };
}
