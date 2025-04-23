{ SELF, config, ... }:
{
  home.file.".xinitrc".source =
    #
    config.lib.file.mkOutOfStoreSymlink "${SELF}/x11/xinitrc";
}
