{ config, ... }:
{
  services.blueman-applet.enable = true;
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 800;
        height = 1100;
        offset = "20x50";
        origin = "top-right";
        transparency = 10;
        frame_color = "#${config.colorScheme.palette.base03}";
        frame_width = 1;
        font = "sans-serif 10";
      };
      urgency_critical = {
        background = "#${config.colorScheme.palette.base08}";
        timeout = 10;
      };
      urgency_normal = {
        background = "#${config.colorScheme.palette.base0B}";
        # foreground = "#${config.colorScheme.palette.base00}";
        timeout = 10;
      };
      urgency_low = {
        background = "#${config.colorScheme.palette.base00}";
        timeout = 10;
      };
    };
  };
  services.mpris-proxy.enable = true; # Using Bluetooth headset buttons to control media player
  services.sxhkd = {
    enable = true;
  };
}
