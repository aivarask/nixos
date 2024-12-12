{ ... }:
{
  xdg.configFile."lf/icons".source = ./lf_icons;
  programs.lf = {
    enable = true;
    # ~/.config/lf/lfrc
    extraConfig = ''
      source /etc/nixos/config/programs_/lfrc
    '';
  };
}
