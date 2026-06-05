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
        xdg.configFile."eza" = {
          source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/eza";
          force = true;
          enable = true;
        };
        programs.eza.enable = true;
        programs.eza.icons = "auto";
        programs.eza.enableZshIntegration = false;
      }
    )
  ];
}
