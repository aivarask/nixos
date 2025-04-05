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
      scripts = with pkgs.mpvScripts; [ pkgs.mpvScripts.uosc ];
    }
  );
  # MPV_HOME="/etc/nixos/mpv";
  xdg.configFile."mpv".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/mpv";
}
