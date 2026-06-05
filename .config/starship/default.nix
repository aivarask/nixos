{ ... }:
{
  home-manager.sharedModules = [
    (
      {
        pkgs,
        config,
        xdgconf,
        lib,
        ...
      }:
      {
        home.sessionVariables.STARSHIP_CONFIG = lib.mkForce "${config.xdg.configHome}/starship/starship.toml";
        xdg.configFile."starship".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/starship";
        programs.starship.enable = true;
        programs.starship.enableBashIntegration = true;
        programs.starship.enableZshIntegration = true;
      }
    )
  ];
}
