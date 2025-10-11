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
      services.conky.enable = false;

      home.packages = [
        # pkgs.conky # fails
      ];
      xdg.configFile."conky/conky.conf".source =
        config.lib.file.mkOutOfStoreSymlink "${SELF}/x11/cf_conky.lua";
    };
}
