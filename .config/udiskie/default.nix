{
  pkgs,
  config,
  osConfig,
  xdgconf,
  ...
}:
{

  xdg.configFile."udiskie".source = osConfig.symlink "${xdgconf}/udiskie";

  services.udiskie.enable = true;
  home.packages = with pkgs; [
    udiskie
  ];
}
