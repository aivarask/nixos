{ ... }:
{

  home-manager.sharedModules = [
    (
      {
        pkgs,
        osConfig,
        ...
      }:

      {

        home.packages = with pkgs; [
          dav1d
          obs-cli
          yt-dlp
        ];
        xdg.configFile."mpv".source = osConfig.symlink "/etc/nixos/modules/mpv";
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
