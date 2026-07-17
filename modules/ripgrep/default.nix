{ ... }:
{
  home-manager.sharedModules = [
    (
      {
        config,
        ...
      }:
      {
        xdg.configFile."ripgrep".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/ripgrep";
      }
    )
  ];
}
