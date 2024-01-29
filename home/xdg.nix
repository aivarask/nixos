{ pkgs, ... }: {
  xdg.configFile = {
    "nicotine/config_def" = {
      source = ../files/nicotine_config;
      enable = true;
      recursive = true;
      onChange = ''
        cat /root/.config/nicotine/config_def > /root/.config/nicotine/config
      '';
    };
    "tilda/config_0" = {
      source = ../files/tilda_config_0;
      enable = true;
    };
  };
}
