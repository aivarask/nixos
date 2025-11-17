{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    lnav
    # lnav_='lnav -I /etc/nixos/prog_/ /var/log/Xorg.0.log $XDG_STATE_HOME/nvim/*.log'\
  ];
}
