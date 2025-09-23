{
  system =
    { pkgs, ... }:
    {
      environment.sytemPackages = with pkgs; [
        yt-dlp
        ytdl-sub
      ];
    };
  hm =
    { pkgs, config, ... }:
    {
      xdg.configFile."yt-dlp".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/yt-dlp";
    };

}
