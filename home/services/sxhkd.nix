{ pkgs, config, ... }: {
  # https://github.com/baskerville/sxhkd


  services.sxhkd = {
    enable = true;
    keybindings = {
      # Func
      "super + F1" = "";
      "super + F2" = ''notify-send 'Keys' "$(cat $XDG_CONFIG_HOME/sxhkd/sxhkdrc)"'';
      "super + F3" = "";
      "super + F4" = "";
      "super + F5" = "";
      "super + F6" = "";
      "super + F7" = "kill -SIGUSR1 $(pidof sxhkd) && dunstify '♻️  sxhkd reloaded'";
      "super + F8" = "";
      "super + F9" = "";
      "super + F10" = "";
      "super + F11" = "";
      "super + F12" = "";
      # Media
      "XF86Audio{Play,Mute,Prev,Next}" = "mpc {play,stop,prev,next}";
      "XF86Audio{Lower,Raise}Volume" = "pulsemixer --change-volume {-,+}2 --max-volume 100";

      "XF86Search" = "";
      "XF86MonBrightness{Down,Up}" = "brightnessctl set 10%{-,+}";

      "Break" = "";
      "Pause" = "";
      "Print" = "scrot";
      "Scroll_Lock" = "";

      "XF86HomePage" = "";
      "XF86Mail" = "telegram-desktop";
      "XF86Calculator" = "";
      # Important
      "super + ctrl + Return" = "tabbed -c alacritty --embed";
      # Keys
      "super + {w,e,r}" = "{$BROWSER,alacritty --working-directory=/etc/nixos -e nvim,dunstify 'empty'}";
      "super + {a,s}" = "pulsemixer --change-volume {-,+}2 --max-volume 100";
      "super + {z,x}" = "{brightnessctl set 10%-,brightnessctl set 10%+}";
      # Upper keys
      "super + {W,E}" = "{firefox --private-window,}";
    };
  };
}
