# vim: nofoldenable
{
  inputs = {
    # nixpkgs.url = "nixpkgs";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { self, rust-overlay }:
    {
      nixosModules = {
        default =
          { pkgs, ... }:
          {
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
            # environment.variables.LD_LIBRARY_PATH = "${pkgs.lldb.lib}/lib/liblldb.so"; # conflicts with jack/lib
            environment.systemPackages = with pkgs; [
              pkgs.rust-bin.stable.latest.default
              cargo
              cargo-nextest
              rustc
              rust-analyzer
              rustfmt
            ];
          };
      };
    };
}
