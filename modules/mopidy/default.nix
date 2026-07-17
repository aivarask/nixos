# https://docs.mopidy.com/stable/guides/
# https://mopidy.com/ext/
{ pkgs, ... }:
{
  home-manager.sharedModules = [
    (
      {
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
        #   config.lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/mopidy/mopidy.conf";
      }
    )
  ];
  environment.systemPackages = with pkgs; [
    mopidy
  ];

}
