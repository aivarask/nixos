{ ... }:
{

  home-manager.sharedModules = [
    (
      {
        pkgs,
        config,
        xdgconf,
        osConfig,
        ...
      }:

      {

        home.packages = with pkgs; [
          dav1d
          obs-cli
          yt-dlp
        ];
        xdg.configFile."mpv".source = osConfig.symlink "${xdgconf}/mpv";
        programs.mpv.enable = true;
        programs.mpv.package = (
          pkgs.mpv.override {
            # vapoursynthSupport = true;
            youtubeSupport = true;
            scripts = with pkgs.mpvScripts; [
              reload
            ];
          }
        );
      }
    )
  ];

}
