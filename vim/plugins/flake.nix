# https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/vim.section.md#adding-new-plugins-to-nixpkgs-adding-new-plugins-to-nixpkgs
# https://wiki.nixos.org/wiki/Vim#Add_a_new_custom_plugin_to_the_users_packages
{
  inputs = {
  };
  outputs =
    { self, ... }@inputs:
    {
      nixosModules.default =
        { config, ... }:
        {
          options = { };
          config = { };
        };
      templates.default = {
        path = "./template.nix";
        description = "";
      };
    };
}
