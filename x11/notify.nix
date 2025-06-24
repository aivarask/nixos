{
  hm =
    {
      pkgs,
      config,
      SELF,
      ...
    }:
    {
      imports = [ ];
      services.systembus-notify.enable = true;
      services.conky.enable = true;

      home.packages = [ pkgs.conky ];
      xdg.configFile."conky/conky.conf".source =
        config.lib.file.mkOutOfStoreSymlink "${SELF}/x11/cf_conky.lua";
    };
}
