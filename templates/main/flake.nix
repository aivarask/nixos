# vim: nofoldenable
{
  description = "";
  inputs = {
    nixpkgs.url = "nixpkgs";
    systems.url = "systems";
  };
  outputs =
    { nixpkgs, systems, ... }:
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
    { };
}
