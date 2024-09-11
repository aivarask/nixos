{ ... }:
{
  xdg.configFile = {
    "nicotine/config_def" = {
      source = ./xdg_nicotine;
      enable = true;
      recursive = true;
      onChange = ''
        cat /root/.config/nicotine/config_def > /root/.config/nicotine/config
      '';
    };
  };
}
