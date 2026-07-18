{ ... }:
{
  home-manager.sharedModules = [
    (
      {
        pkgs,
        config,
        ...
      }:
      {
        home.packages = with pkgs; [
          nicotine-plus
        ];
        xdg.configFile."nicotine" = {
          source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/nicotine";
          enable = true;
          force = true;
          recursive = true;
        };

      }
    )
  ];
}
