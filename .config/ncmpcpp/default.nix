{ ... }:
{
  home-manager.sharedModules = [
    (
      {
        pkgs,
        xdgconf,
        config,
        ...
      }:
      {
        programs.ncmpcpp.enable = true;
        xdg.configFile."ncmpcpp/config" = {
          source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/ncmpcpp/config";
          enable = true;
          force = true;
        };
        xdg.configFile."ncmpcpp/bindings" = {
          source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/ncmpcpp/bindings";
          enable = true;
          force = true;
        };

      }
    )
  ];
}
