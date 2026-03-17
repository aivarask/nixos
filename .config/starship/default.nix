{
  pkgs,
  config,
  osConfig,
  xdgconf,
  ...
}:
{
  home.sessionVariables.STARSHIP_CONFIG = "${config.xdg.configHome}/starship/starship.toml";
  xdg.configFile."starship.toml".source = osConfig.symlink "${xdgconf}/starship.toml";
  programs.starship.enable = true;
  programs.starship.enableBashIntegration = true;
  programs.starship.enableZshIntegration = true;
}
