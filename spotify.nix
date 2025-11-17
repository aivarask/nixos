{
  hm =
    { config, ... }:
    {
    };
  system =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
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
