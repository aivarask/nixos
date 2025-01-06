{ pkgs, ... }:
{

  # lnav_='lnav -I /etc/nixos/lnav/ /var/log/Xorg.0.log $XDG_STATE_HOME/nvim/*.log'\
  environment.systemPackages = with pkgs; [ lnav ];
}
