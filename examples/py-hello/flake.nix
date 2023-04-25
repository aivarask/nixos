{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }: let
    inherit (nixpkgs) lib;

    # Add the flake's overlay to each of the pkgs
    eachDefaultEnvironment = f:
      flake-utils.lib.eachDefaultSystem
      (
        system:
          f {
            inherit system;
            pkgs =
              (import nixpkgs {
                inherit system;
                config.allowUnfree = true;
              })
              .extend
              self.overlay;
          }
      );
  in
    eachDefaultEnvironment
    ({
      pkgs,
      system,
    }: {
      devShell = import ./shell.nix ({inherit pkgs;} // self.packages."${system}");

      packages = rec {
        inherit (pkgs.python3Packages) py-hello;
      };

      defaultPackage = self.packages."${system}".py-hello;
    })
    // {
      overlay = import ./overlay.nix self.inputs;
      checks = self.packages;
    };
}
