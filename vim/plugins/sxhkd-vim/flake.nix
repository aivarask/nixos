# https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/vim.section.md#adding-new-plugins-to-nixpkgs-adding-new-plugins-to-nixpkgs
# https://wiki.nixos.org/wiki/Vim#Add_a_new_custom_plugin_to_the_users_packages
{
  inputs = {
    plugin = {
      url = "github:kovetskiy/sxhkd-vim";
      flake = false;
    };
  };
  outputs =
    { self, ... }@inputs:
    {
      overlays.default = final: prev: {
        vimPlugins = prev.vimPlugins // {
          "sxhkd-vim" = prev.vimUtils.buildVimPlugin {
            name = "sxhkd-vim";
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
        { pkgs, ... }:
        {
          nixpkgs.overlays = [ self.overlays.default ];
          programs.vim.plugins = [ pkgs.vimPlugins.sxhkd-vim ];
          programs.neovim.plugins = [ pkgs.vimPlugins.sxhkd-vim ];
        };
    };
}
