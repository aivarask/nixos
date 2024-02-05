{ lib, config, ... }:
{
  services.dwm-status = {
    enable = true;
    extraConfig = ''
      separator = " "

      [audio]
      control = "Master Playback Volume"
      mute = "MUTE"
      template = "{ICO} {VOL}"
      icons = ["🔈", "🔉", "🔊"]

      [backlight]
      device = "intel_backlight"
      template = "{ICO} {BL}"
      icons = ["🔅", "🔆", "😎"]

      [battery]
      charging = "▲"
      discharging = "▼"
      enable_notifier = true
      no_battery = ""
      notifier_critical = 10
      notifier_levels = [2, 5, 10, 15, 20]
      separator = "·"
      icons = ["🪫", "🔋", "🔋"]

      [cpu_load]
      template = "🤖 {CL1} {CL5} {CL15}"
      update_interval = 20

      [network]
      no_value = "🌑"
      template = "🌐 {IPv4} 📶 {ESSID}"

      [time]
      format = "📆 %Y-%m-%d %H:%M"
      update_seconds = false
    '';
    # https://stackoverflow.com/questions/75668045/nix-coding-pattern-merging-two-conditional-lists-created-with-mkif
    order = lib.mkMerge [
      # "audio"
      (lib.mkIf (config.networking.hostName == "dell") [ "backlight" "battery" ])
      [
        "cpu_load"
        "network"
        "time"
      ]
    ];
  };
}
