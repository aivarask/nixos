# https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/vim.section.md#adding-new-plugins-to-nixpkgs-adding-new-plugins-to-nixpkgs
# https://wiki.nixos.org/wiki/Vim#Add_a_new_custom_plugin_to_the_users_packages
{
  inputs = {
    plugin = {
      url = "";
      flake = false;
    };
  };
  outputs =
    { self, ... }@inputs:
    {
      overlays.default = final: prev: {
        vimPlugins = prev.vimPlugins // {
          "" = prev.vimUtils.buildVimPlugin {
            name = "nvim-dap-vscode-js";
            src = inputs.plugin;
            meta = {
              homepage = inputs.plugin.url;
            };
          };
        };
      };
      nixosModules.default =
        { ... }:
        {
        };
      nixosModules.home =
        { config, ... }:
        {
          options = { };
          config = { };
        };
    };
}
