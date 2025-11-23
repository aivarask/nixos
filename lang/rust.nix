{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];
  # environment.variables.LD_LIBRARY_PATH = "${pkgs.lldb.lib}/lib/liblldb.so"; # conflicts with jack/lib
  environment.systemPackages = with pkgs; [
    pkgs.rust-bin.stable.latest.default
    cargo
    cargo-nextest
    rustc
    rust-analyzer
    rustfmt
  ];
}
