{ config, pkgs, ... }: {
  services.sxhkd = {
    enable = true;
    keybindings = {
      "Break" = "$TERMINAL -e pulsemixer";
      "Pause" = "$TERMINAL -e ncmpcpp";
      "Print" = "$TERMINAL -e htop";
      "Scroll_Lock" = "$TERMINAL -e tremc";
      "XF86Audio{Lower,Raise}Volume" = "pulsemixer --change-volume {-,+}2";
      "XF86Audio{Play,Mute}" = "mpc {play,stop}";
      "XF86Audio{Prev,Next}" = "mpc {prev,next}";
      "XF86Calculator" = "$TERMINAL -e bandwhich";
      "XF86HomePage" = "google-chrome-stable --no-sandbox";
      "XF86Mail" = "brave --no-sandbox";
      "alt + F12" = "$SHELL -c 'nixos-rebuild switch | xargs dunstify'";
      "alt + F5" = "systemctl restart cron.service";
      "alt + F6" = "xset r rate 200 50";
      "alt + F7" = "kill -SIGUSR1 $(pidof sxhkd)";
      "alt + W" = "brave --no-sandbox";
      "alt + XF86Audio{Lower,Raise}Volume" = "mpc {prev,next}";
      "alt + XF86Mail" = "telegram-desktop";
      "alt + w" = "$BROWSER";
      "ctrl + Pause" = "nicotine-plus";
      "ctrl + Print;" = "$TERMINAL -e duf &";
      "ctrl + alt + Return" = "tabbed -c alacritty --embed";
      # "super + {g,m}" = "$BROWSER {github.com,messenger.com}";
      # "super + m" = "$TERMINAL -e duf";
    };
  };
}
