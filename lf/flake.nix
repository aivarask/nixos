{
  outputs =
    { ... }:
    {
      nixosModules = {
        default =
          { ... }:
          {
            # environment.profiles = [ "${./.}" ];
          };
        yazi.home =
          { ... }:
          {
          };
        home =
          { ... }:
          {
          };

      };
    };
}
