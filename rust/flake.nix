# vim: nofoldenable
{
  inputs = {
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { self, rust-overlay }:
    {
      nixosModules.default =
        { pkgs, ... }:
        {
          nixpkgs.overlays = [ rust-overlay.overlays.default ];
          environment.systemPackages = [
            pkgs.rust-bin.stable.latest.default
          ];
        };
    };
}
