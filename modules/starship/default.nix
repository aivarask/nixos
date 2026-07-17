{ ... }:
{
  home-manager.sharedModules = [
    (
      {
        config,
        lib,
        ...
      }:
      {
        home.sessionVariables.STARSHIP_CONFIG = lib.mkForce "${config.xdg.configHome}/starship/starship.toml";
        xdg.configFile."starship".source =
          config.lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/starship";
        programs.starship.enable = true;
        programs.starship.enableBashIntegration = true;
        programs.starship.enableZshIntegration = true;
      }
    )
  ];
}
