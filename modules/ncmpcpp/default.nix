{ ... }:
{
  home-manager.sharedModules = [
    (
      {
        config,
        ...
      }:
      {
        programs.ncmpcpp.enable = true;
        xdg.configFile."ncmpcpp/config" = {
          source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/ncmpcpp/config";
          enable = true;
          force = true;
        };
        xdg.configFile."ncmpcpp/bindings" = {
          source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/ncmpcpp/bindings";
          enable = true;
          force = true;
        };

      }
    )
  ];
}
