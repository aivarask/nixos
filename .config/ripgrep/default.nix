{ ... }:
{
  home-manager.sharedModules = [
    (
      {
        pkgs,
        config,
        xdgconf,
        ...
      }:
      {
        xdg.configFile."ripgrep".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/ripgrep";
      }
    )
  ];
}
