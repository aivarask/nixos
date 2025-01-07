{
  inputs = {
    nvim-dap-vscode-js = {
      url = "github:mxsdev/nvim-dap-vscode-js";
      flake = false;
    };
  };
  outputs =
    { nvim-dap-vscode-js, ... }:
    {
      overlays.default = final: prev: {
        vimPlugins = prev.vimPlugins // {
          nvim-dap-vscode-js = prev.vimUtils.buildVimPlugin {
            name = "nvim-dap-vscode-js";
            src = nvim-dap-vscode-js;
            meta = {
              homepage = "https://github.com/mxsdev/nvim-dap-vscode-js";
            };
          };
        };
      };
      nixosModules.home = { ... }: { };
    };
}
