# https://docs.mopidy.com/stable/guides/
# https://mopidy.com/ext/
{ pkgs, ... }:
{
  home-manager.sharedModules = [
    (
      {
        config,
        xdgconf,
        pkgs,
        ...
      }:
      {
        services.mopidy.enable = true;

        services.mopidy.extensionPackages = with pkgs.mopidyPackages; [
          mopidy-mpd
          mopidy-spotify
        ];
        services.mopidy.settings = { };
        # xdg.configFile."mopidy/mopidy.conf".source =
        #   config.lib.file.mkOutOfStoreSymlink "${xdgconf}/mopidy/mopidy.conf";
      }
    )
  ];
  environment.systemPackages = with pkgs; [
    mopidy
  ];

}
