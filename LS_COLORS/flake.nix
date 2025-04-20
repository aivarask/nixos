{
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
