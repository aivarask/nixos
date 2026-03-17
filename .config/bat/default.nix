{
  pkgs,
  osConfig,
  xdgconf,
  ...
}:
{
  xdg.configFile."bat".source = osConfig.symlink "${xdgconf}/bat";
  programs.bat.enable = true;
  programs.bat.extraPackages = with pkgs.bat-extras; [
    batgrep
    batman
    batpipe
    batwatch
    batdiff
    prettybat
  ];

}
