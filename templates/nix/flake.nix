# vim: nofoldenable
{
  description = "";
  inputs = {
    nixpkgs.url = "nixpkgs";
    systems.url = "systems";
  };
  outputs =
    { ... }@inputs:
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
