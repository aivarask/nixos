{
  hm =
    { config, ... }:
    {
      # $XDG_CONFIG_HOME/ncspot/config.toml
      # xdg.configFile."ncspot/config.toml".source =
      #   config.lib.file.mkOutOfStoreSymlink "/etc/nixos/ncspot_config.toml";
      xdg.configFile."spotify-flags.conf".source =
        config.lib.file.mkOutOfStoreSymlink "/etc/nixos/spotify-flags.conf";
    };
  system =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ncspot
        spotify
      ];

      # https://docs.spotifyd.rs
      # https://github.com/Spotifyd/spotifyd/issues
      # services.playerctld.enable = true;
      systemd.packages = with pkgs; [ playerctl ];

      # systemd.tmpfiles.settings."10-spotifyd" = {
      #   "/root/.config/spotifyd/spotifyd.conf" = {
      #     "L+" = {
      #       user = "root";
      #       group = "root";
      #       mode = "0777";
      #       type = "L+";
      #       argument = "/etc/nixos/spotifyd.conf";
      #     };
      #   };
      # };
    };
}
