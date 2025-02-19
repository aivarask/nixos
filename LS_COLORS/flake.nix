{
  inputs.LS_COLORS.url = "github:trapd00r/LS_COLORS";
  inputs.LS_COLORS.flake = false;
  outputs =
    { self, LS_COLORS, ... }:
    {
      overlays.default = _: _: { inherit LS_COLORS; };
      nixosModules.default =
        { ... }:
        {
          nixpkgs.overlays = [ self.overlays.default ];
        };
    };
}
