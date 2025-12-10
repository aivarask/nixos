{
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
        eww
        uwsm
        sway
        sway-easyfocus
        sway-launcher-desktop
        sway-contrib.inactive-windows-transparency
        sway-contrib.grimshot
        # sway-overfocus
        sway-new-workspace
        sway-scratch
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
        wttrbar
        lxappearance
        xkeyboard-config
        xorg.xkbcomp
        xcursor-pro
        mojave-gtk-theme
        oranchelo-icon-theme
        papirus-icon-theme
        gnome-themes-extra
        orchis-theme
        jasper-gtk-theme
        fluent-gtk-theme
        fluent-icon-theme
      ];

      services.xserver.exportConfiguration = true;
      services.gnome.gnome-keyring.enable = true;
      programs.sway.enable = true;
      programs.sway.wrapperFeatures.gtk = true;

    };
}
