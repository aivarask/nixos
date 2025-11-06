{
  pkgs,
  config,
  SELF,
  ...
}:
{
  programs.bat.enable = true;
  xdg.configFile."bat/config".source = config.lib.file.mkOutOfStoreSymlink "${SELF}/sh/bat.config";
  programs.bat.extraPackages = with pkgs.bat-extras; [
    # batgrep # fails
    batman
    batpipe
    batwatch
    batdiff
    prettybat
  ];
}
