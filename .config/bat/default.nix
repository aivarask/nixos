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
        xdg.configFile."bat".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/bat";
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
    )
  ];

}
