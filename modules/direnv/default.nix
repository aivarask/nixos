{ ... }:
{
  home-manager.sharedModules = [
    (
      {
        config,
        ...
      }:
      {

        programs.direnv.enable = true;
        programs.direnv.nix-direnv.enable = true;
        programs.direnv.enableBashIntegration = true;
        programs.direnv.enableZshIntegration = true;
        xdg.configFile."direnv/direnv.toml" = {
          source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/direnv/direnv.toml";
          enable = true;
          force = true;
        };

      }
    )
  ];
}
