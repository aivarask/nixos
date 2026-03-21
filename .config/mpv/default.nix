{
  pkgs,
  config,
  xdgconf,
  osConfig,
  ...
}:

{
  home.packages = with pkgs; [
    celluloid
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
        pkgs.mpvScripts.uosc # https://github.com/tomasklaen/uosc
        pkgs.mpvScripts.reload # https://github.com/4e6/mpv-reload
      ];
    }
  );
}
