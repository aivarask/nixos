{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = with inputs; [ (_: _: { inherit LS_COLORS; }) ];
}
