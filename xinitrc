#!/bin/sh

if test "$DBUS_SESSION_BUS_ADDRESS" = ""; then
  eval "$(dbus-launch --exit-with-session --sh-syntax)"
fi
systemctl --user import-environment DISPLAY XAUTHORITY

if command -v dbus-update-activation-environment >/dev/null 2>&1; then
  dbus-update-activation-environment DISPLAY XAUTHORITY
fi

# https://www.iodocs.com/how-to-enable-gpu-fan-settings-nvidia-in-linux/
nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:0]/GPUTargetFanSpeed=40' --load-config-only

numlockx
xset r rate 200 50

unclutter &
redshift &
dunst &
slstatus &
sxhkd &
imwheel -b 45 &
DISPLAY=:0 feh --bg-fill --randomize /etc/nixos/misc/wallpapers/abstract/*

XDG_SESSION_TYPE=x11 remote-touchpad -bind :9000 -secret pc &
# ssh-chat --bind 2022 &
# wetty -b / -p 9999 &

# https://wiki.archlinux.org/title/Xinit
session=${1:-dwm}

case $session in
  foo) echo 'Foo to exec' ;;
  i3 | i3wm) exec i3 ;;
  kde) exec startplasma-x11 ;;
  xfce | xfce4) exec startxfce4 ;;
  dwm) exec dwm ;;
  *) exec "$1" ;;
esac
