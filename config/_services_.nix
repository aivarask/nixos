{ config, ... }:
{
  services.blueman-applet.enable = true;
  services.conky.enable = true;
  services.dunst = {
    # https://smarttech101.com/how-to-configure-dunst-notifications-in-linux-with-images
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
  services.mpris-proxy.enable = true;
  home.sessionVariables.SXHKDRC = "/etc/nixos/config/files/sxhkdrc";
  services.sxhkd.enable = true;

}
