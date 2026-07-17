{ ... }:
{
  home-manager.sharedModules = [
    (
      {
        config,
        ...
      }:
      {
        xdg.configFile."eza" = {
          source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/eza";
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
