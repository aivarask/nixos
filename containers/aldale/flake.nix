{
  outputs =
    { self, ... }:
    {
      nixosModules.default =
        { config, ... }:
        {
          imports = [
            ./.
            ./httpd.nix
          ];
        };
    };
}
