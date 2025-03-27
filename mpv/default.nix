{ pkgs, ... }:
{
  # MPV_HOME="/etc/nixos/mpv";
  # https://github.com/mpv-player/mpv/blob/master/etc/input.conf
  programs.mpv.enable = true;

  programs.mpv.package = (
    pkgs.mpv-unwrapped.wrapper {
      mpv = pkgs.mpv-unwrapped.override {
        # waylandSupport = true;
      };
      scripts = with pkgs.mpvScripts; [ pkgs.mpvScripts.uosc ];
    }
  );

}
