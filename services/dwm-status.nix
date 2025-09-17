{ lib, config, ... }:
{
  services.dwm-status = {
    enable = true;
    # https://github.com/Gerschtli/dwm-status
    settings =
      builtins.fromTOML ''
        separator = " "

        [audio]
        control = "Master"
        mute = "MUTE"
        template = "{ICO}{VOL}"
        icons = ["🔈", "🔉", "🔊"]

        [backlight]
        device = "intel_backlight"
        template = "{ICO}{BL}"
        icons = ["🔅", "🔆", "😎"]

        [battery]
        charging = "🔌"
        discharging = "🔦"
        enable_notifier = true
        no_battery = ""
        notifier_critical = 10
        notifier_levels = [2, 5, 10, 15, 20]
        separator = ""
        icons = ["🪫", "🔋", "🔋"]

        [cpu_load]
        template = "🤖 {CL1} {CL5} {CL15}"
        update_interval = 20

        [network]
        no_value = "🌑"
        template = "📶{ESSID}"
        # template = "🌐{IPv4} 📶{ESSID}"

        [time]
        format = "📆%m-%d %H:%M"
        update_seconds = false

      ''
      // {
        order = lib.mkMerge [
          (lib.mkIf (config.networking.hostName == "dell") [
            "backlight"
            "battery"
          ])
          [
            "audio"
            # "cpu_load"
            "network"
            "time"
          ]
        ];

      };
  };
}
