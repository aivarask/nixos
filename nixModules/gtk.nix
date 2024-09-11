{ pkgs, ... }: { environment.systemPackages = with pkgs; [ gtk3 gtk3-x11 layan-gtk-theme gruvbox-dark-gtk gruvbox-dark-icons-gtk ]; }
