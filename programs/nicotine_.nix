{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nicotine-plus # GDK_SCALE = "2";
  ];
  xdg.configFile = {
    "nicotine/config_def" = {
      source = ./nicotine;
      enable = true;
      recursive = true;
      onChange = ''
        cat /root/.config/nicotine/config_def > /root/.config/nicotine/config
      '';
    };
  };

}
