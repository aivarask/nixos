{
  config,
  pkgs,
  SELF,
  ...
}:

{

  home.packages = with pkgs; [
    lnav # lnav_='lnav -I /etc/nixos/prog_/ /var/log/Xorg.0.log $XDG_STATE_HOME/nvim/*.log'\
    htop
    lf
  ];
  xdg.configFile."htop".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.config/htop";
  xdg.configFile."lf".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.config/lf";
  xdg.configFile."lnav".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.config/lnav";
  xdg.configFile."mpv".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.config/mpv";
  programs.mpv.enable = true;
  programs.mpv.package = (
    pkgs.mpv-unwrapped.wrapper {
      mpv = pkgs.mpv-unwrapped.override {
        # waylandSupport = true;
      };
      scripts = with pkgs.mpvScripts; [
        pkgs.mpvScripts.uosc # https://github.com/tomasklaen/uosc
        pkgs.mpvScripts.reload # https://github.com/4e6/mpv-reload
      ];
    }
  );
  # MPV_HOME="/etc/nixos/mpv";
  programs.ncmpcpp.enable = true;
  xdg.configFile."ncmpcpp/config" = {
    enable = true;
    force = true;
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/ncmpcpp/config";
  };
  xdg.configFile."ncmpcpp/bindings" = {
    enable = true;
    force = true;
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/ncmpcpp/bindings";
  };

  programs.pistol.enable = true;
  xdg.configFile."pistol".source = config.lib.file.mkOutOfStoreSymlink "${SELF}/.config/pistol";
}
