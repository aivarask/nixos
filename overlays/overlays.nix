self: super:
with super.lib; let
  inherit ((import <nixpkgs/nixos> {}).config.nixpkgs) overlays;
in
  # Apply all overlays to the input of the current "main" overlay
  foldl' (flip extends) (_: super) overlays self
