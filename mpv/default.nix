{
  pkgs,
  config,
  osConfig,
  ...
}:
{
  programs.mpv.enable = true;
  programs.mpv.package = (
    pkgs.mpv-unwrapped.wrapper {
      mpv = pkgs.mpv-unwrapped.override {
        # waylandSupport = true;
      };
      scripts = with pkgs.mpvScripts; [
        pkgs.mpvScripts.uosc # https://github.com/tomasklaen/uosc
        pkgs.mpvScripts.reload # https://github.com/4e6/mpv-reload
      ];
    }
  );
  # MPV_HOME="/etc/nixos/mpv";
  xdg.configFile."mpv".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/mpv";
}
