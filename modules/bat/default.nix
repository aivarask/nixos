{ ... }:
{
  home-manager.sharedModules = [
    (
      {
        pkgs,
        config,
        ...
      }:
      {
        xdg.configFile."bat".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/bat";
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
