#!/bin/sh
session=${1:-dwm}

case $session in
  i3 | i3wm) echo i3 ;;
  kde) echo startplasma-x11 ;;
  xfce | xfce4) echo startxfce4 ;;
  dwm) echo dwm ;;
  *) echo $1 ;;
esac
