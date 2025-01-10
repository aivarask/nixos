{
  inputs = {
    sxhkd-vim.url = "./sxhkd-vim";
  };
  outputs =
    { self, ... }@inputs:
    {
      # overlays.default = [ inputs.sxhkd-vim.overlays.default ];
      nixosModules = {
        default = _: {
          imports = [
            inputs.sxhkd-vim.nixosModules.default
          ];
        };
        home = _: {
          imports = [
            inputs.sxhkd-vim.nixosModules.home
          ];
        };
      };
      templates._ = {
        path = ./_;
      };
    };
}
