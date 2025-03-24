{ pkgs, ... }:
{
  # https://mpv.io/manual/master/#playlist-manipulation
  programs.mpv = {
    enable = true;
    package = (
      pkgs.mpv-unwrapped.wrapper {
        scripts = with pkgs.mpvScripts; [
          uosc
          # sponsorblock
        ];
        mpv = pkgs.mpv-unwrapped.override {
          # waylandSupport = true;
        };
      }
    );
    config = {
      # https://mpv.io/manual/master/#options-hwdec
      hwdec = "vaapi";
    };
  };
}
