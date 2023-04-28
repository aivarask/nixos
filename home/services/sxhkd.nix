_: {
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
      "XF86HomePage" = "chromium";
      "XF86Mail" = "brave --no-sandbox";

      "super + F1" = "TEXT=$(cat /etc/nixos/sxhkd.nix) && dunstify $TEXT";
      "super + F2" = "dmenu_open";
      "super + F3" = "emojipick";
      "super + ctrl + F3" = "xdg-open https://emojifinder.com/";
      "super + F6" = "xset r rate 200 50";
      "super + F7" = "kill -SIGUSR1 $(pidof sxhkd) && dunstify '♻️  sxhkd reloaded'";
      "super + XF86Audio{Lower,Raise}Volume" = "mpc {prev,next}";
      "super + XF86Mail" = "telegram-desktop";
      "super + y" = "youtube-watch";
      "super + w" = "$BROWSER";
      "super + W" = "firefox --private-window";
      "super + ctrl + Return" = "tabbed -c alacritty --embed";
      "ctrl + shift + Return" = "detach";

      "ctrl + Pause" = "nicotine";
      "ctrl + Print;" = "$TERMINAL -e duf &";
      # "super + {g,m}" = "$BROWSER {github.com,messenger.com}";
      # "super + m" = "$TERMINAL -e duf";
      "XF86MonBrightnessDown" = "brightnessctl set 10%-";
      "XF86MonBrightnessUp" = "brightnessctl set +10%";
    };
  };
}
