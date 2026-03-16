{
  pkgs,
  lib,
  xdgconf,
  symlink,
  ...
}:
{
  xdg.configFile."mpv".source = symlink "${xdgconf}/mpv";
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
