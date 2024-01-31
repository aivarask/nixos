_: {
  # https://github.com/baskerville/sxhkd
  services.sxhkd = {
    enable = true;
    keybindings = {
      "Break" = "$TERMINAL -e pulsemixer";
      "Pause" = "$TERMINAL -e ncmpcpp";
      "Print" = "$TERMINAL -e htop";
      "Scroll_Lock" = "$TERMINAL -e tremc";
      "XF86Audio{Lower,Raise}Volume" = "pulsemixer --change-volume {-,+}2 --max-volume 100";
      "XF86Audio{Play,Mute}" = "mpc {play,stop}";
      "XF86Audio{Prev,Next}" = "mpc {prev,next}";
      "XF86Calculator" = "$TERMINAL -e bandwhich";
      "XF86HomePage" = "chromium";
      "XF86Mail" = "brave --no-sandbox";
      "XF86MonBrightnessDown" = "brightnessctl set 10%-";
      "XF86MonBrightnessUp" = "brightnessctl set +10%";
      # "ctrl + Pause" = "ni";
      "ctrl + Print;" = "$TERMINAL -e duf &";
      "ctrl + shift + Return" = "detach";
      "super + F1" = "TEXT=$(cat /etc/nixos/home/services/sxhkd.nix) && dunstify $TEXT";
      "super + F2" = "dmenu_url"; # bin/dmenu_url
      "super + F3" = "emojipick";
      "super + F4" = "dmenu_go";
      "super + F5" = "$TERMINAL -e dmenu_run";
      "super + F6" = "xset r rate 200 50";
      "super + F7" = "kill -SIGUSR1 $(pidof sxhkd) && dunstify '♻️  sxhkd reloaded'";
      "super + F8" = "scrot";
      "super + F9" = "";
      "super + F10" = "";
      "super + F11" = "";
      "super + F12" = "";
      "super + W" = "firefox --private-window";
      "super + XF86Audio{Lower,Raise}Volume" = "mpc {prev,next}";
      "super + XF86Mail" = "telegram-desktop";
      "super + ctrl + F3" = "xdg-open https://emojifinder.com/";
      "super + ctrl + Return" = "tabbed -c alacritty --embed";
      "super + ctrl + m; {a,c,l}" = "mpc clear && mpc load {chill lt, chill, lt}";
      "super + r" = "dmenu_go";
      "super + w" = "$BROWSER";
      "super + x" = "brightnessctl set 10%+";
      "super + y" = "youtube-watch";
      "super + z" = "brightnessctl set 10%-";
      "super + n" = "nix_manual";
      "super + {a,s}" = "pulsemixer --change-volume {-,+}2 --max-volume 100";
      # "super + m" = "$TERMINAL -e duf";
      # "super + {g,m}" = "$BROWSER {github.com,messenger.com}";
      # alias
    };
  };
}
