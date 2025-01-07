{
  inputs = {
    sxhkd-vim.url = "./sxhkd-vim";
  };
  outputs =
    { self, ... }@inputs:
    {
      overlays.default = [ inputs.foo.overlays.default ];
      nixosModules.default =
        { ... }:
        {
          imports = [
            inputs.foo.nixosModules.default
          ];
        };
      nixosModules.home =
        { ... }:
        {
          imports = [ inputs.foo.nixosModules.home ];
        };
      templates._ = {
        path = ./_;
      };
    };
}
