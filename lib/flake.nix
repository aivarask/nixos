{
  outputs =
    { self, ... }:
    {
      overlays.default = _: super: {
        lib = super.lib // {
          aaa = {
            greet = "hello";
          };
        };
      };
      nixosModules.default =
        { ... }:
        {
          nixpkgs.overlays = [ self.overlays.default ];
        };
    };
}
