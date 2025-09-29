{
  system =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        yt-dlp
        ytdl-sub
      ];
    };
  home-manager =
    { pkgs, config, ... }:
    {
      xdg.configFile."yt-dlp".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/yt-dlp";
    };

}
