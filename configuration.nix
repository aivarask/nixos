{...}:
# let
#   config = builtins.dirOf (builtins.findFile builtins.nixPath "nixos-config");
#   vim = ./vim/ftplugin;
#   foo = map (dir: "${vim}/${dir}") (builtins.attrNames (builtins.readDir vim));
#   boo =
#     builtins.filterSource
#     (path: type: type == "directory")
#     ./.gitignore;
# in
{
  imports =
    [
      ./systemPackages
      ./vim/ftplugin
    ]
      ++ (import ./modules/module-list.nix);


}
