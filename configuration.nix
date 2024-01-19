{ pkgs, ... }: {
  imports =
    [
      ./systemPackages
      ./plugin
    ]
    ++ (import ./modules/module-list.nix);
}
