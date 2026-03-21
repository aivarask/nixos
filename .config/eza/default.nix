{
  pkgs,
  config,
  xdgconf,
  osConfig,
  ...
}:
{
  xdg.configFile."eza" = {
    source = osConfig.symlink "${xdgconf}/eza";
    force = true;
    enable = true;
  };
  programs.eza.enable = true;
  programs.eza.icons = "auto";
  programs.eza.enableZshIntegration = false;
}
