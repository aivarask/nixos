{
  hm =
    { config, ... }:
    {
      xdg.configFile."foot/foot.ini".source =
        config.lib.file.mkOutOfStoreSymlink "/etc/nixos/sway/foot.ini";
      xdg.configFile."sway".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/sway";
      xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/sway/waybar";
      xdg.configFile."gtk-3.0/settings.ini".source =
        config.lib.file.mkOutOfStoreSymlink "/etc/nixos/gtk-3.0_settings.ini";
      xdg.configFile."gtk-4.0/settings.ini".source =
        config.lib.file.mkOutOfStoreSymlink "/etc/nixos/gtk-4.0_settings.ini";
    };
  system =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      programs.uwsm.enable = true;
      programs.uwsm.waylandCompositors.sway.binPath = "${pkgs.sway}/bin/sway";
      programs.uwsm.waylandCompositors.sway.prettyName = "mysway";
      # programs.uwsm.waylandCompositors.hyprland.prettyName = "Hyprland";
      programs.hyprland.enable = true;
      programs.hyprland.withUWSM = true;
      environment.systemPackages = with pkgs; [
        uwsm
        sway
        i3
        wev
        wlr-which-key
        grim # screenshot functionality
        slurp # screenshot functionality
        wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
        mako # notification system developed by swaywm maintainer
        swaynotificationcenter
        gammastep
        waybar
        gtk4
        gtk-doc
        gtk3
        lxappearance
        xkeyboard-config
        xorg.xkbcomp
        xcursor-pro
        mojave-gtk-theme
        oranchelo-icon-theme
        papirus-icon-theme
        numix-sx-gtk-theme
        numix-icon-theme
        numix-gtk-theme
        gnome-themes-extra
        orchis-theme
        jasper-gtk-theme
        fluent-gtk-theme
        fluent-icon-theme
        colloid-gtk-theme
        colloid-icon-theme
        catppuccin-gtk
        catppuccin
      ];
      environment.etc."themes/catppuccin".source = pkgs.catppuccin;

      services.gnome.gnome-keyring.enable = true;
      programs.sway.enable = true;
      programs.sway.wrapperFeatures.gtk = true;

    };
}
