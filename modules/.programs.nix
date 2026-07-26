{
  inputs,
  SELF,
  xdgconf,
  pkgs,
  ...
}:
{
  programs.xfconf.enable = true;
  programs.thunar.enable = true;

  programs.thunar.plugins = with pkgs; [
    thunar-archive-plugin
    thunar-media-tags-plugin
    thunar-volman
  ];
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  home-manager.sharedModules = [
    {
      home.packages = with pkgs; [
        reaper
        surge-xt
        vital
      ];
    }

    (
      {
        config,
        pkgs,
        ...
      }:
      {
        manual.json.enable = true;
        programs.man.generateCaches = true;
        colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
        xdg.userDirs.enable = true;
        xdg.userDirs.createDirectories = true;
        xdg.userDirs.music = "${config.home.homeDirectory}/Music";
        home.file."${config.xdg.userDirs.pictures}/img".source =
          config.lib.file.mkOutOfStoreSymlink "${SELF}/img";
        xdg.userDirs.extraConfig = {
          MISC = "${config.home.homeDirectory}/Misc";
        };

        imports = [
        ];

        home.packages = with pkgs; [

          # https://github.com/swaywm/sway/wiki/Useful-add-ons-for-sway#bar-content-generators
          # mako
          # sway
          # sway-overfocus
          # wireplumber
          # xdg-desktop-portal-wlr
          bemoji
          bitwarden-cli
          catt
          clipman
          evtest
          eww
          fuzzel
          gammastep
          gcr
          # glib-networking
          grim
          gtk-doc
          gtk3
          gtk4
          htop
          ifwifi
          inkscape-with-extensions
          iperf3
          kanshi
          kdotool
          keyd
          kitty
          libinput
          lingot # guitar tuner
          lnav
          localsend
          mcat
          miraclecast
          mixxx
          nautilus
          ncspot
          ookla-speedtest
          papirus-icon-theme
          pavucontrol
          pipewire
          playerctl
          python3
          roomeqwizard
          setxkbmap
          spotify
          sqlitebrowser
          swayidle
          swaylock
          swayr
          thunar
          thunar-volman
          traceroute
          tumbler
          vimpager
          waybar
          waypipe
          wayvnc
          wdisplays
          wev
          wl-clipboard
          wlr-randr
          wshowkeys
          wttrbar
          wtype
          x11perf
          xcursor-pro
          xdg-launch
          xdg-terminal-exec
          xdg-terminal-exec
          xdg-user-dirs
          xdg-user-dirs-gtk
          xdg-utils # https://www.freedesktop.org/wiki/Software/xdg-utils/
          xkbcomp
          xkeyboard-config
          xmodmap
          ydotool
          # https://nwg-piotr.github.io/nwg-shell/
          # seahorse
          autotiling # autotiling-rs
          dconf-editor
          file-roller
          gcr
          gnome-calculator
          gnome-disk-utility
          gnome-network-displays
          gnome-system-monitor
          gnome-themes-extra
          gnome-tweaks
          gparted
          gtklock
          gvfs
          nwg-bar
          nwg-clipman
          nwg-displays
          nwg-dock
          nwg-drawer
          nwg-hello
          nwg-icon-picker
          nwg-look
          nwg-menu
          nwg-wrapper
          orchis-theme
          swaynotificationcenter
        ];
        xdg.dataFile."nwg-dock/images/grid.svg".source = "${pkgs.nwg-dock-hyprland.out}/images/grid.svg";
        # symlink "/run/current-system/sw/share/icons/Papirus/96x96/apps";
        home.file.".inputrc".source = config.lib.file.mkOutOfStoreSymlink "${SELF}/.inputrc";
        # https://catonmat.net/bash-vi-editing-mode-cheat-sheet
        xdg.configFile."gpu-viewer".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/gpu-viewer";
        xdg.configFile."autostart".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/autostart";
        xdg.configFile."lingot".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/lingot";
        xdg.configFile."Thunar".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/Thunar";
        xdg.configFile."xfce4".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/xfce4";
        xdg.configFile."alias".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/alias";
        xdg.configFile."clangd".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/clangd";
        xdg.configFile."fd".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/fd";
        xdg.configFile."flameshot".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/flameshot";
        xdg.configFile."foot".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/foot";
        xdg.configFile."fuzzel".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/fuzzel";
        xdg.configFile."gammastep".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/gammastep";
        xdg.configFile."gamescope".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/gamescope";
        xdg.configFile."gtk-2.0".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/gtk-2.0";
        xdg.configFile."gtk-3.0".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/gtk-3.0";
        xdg.configFile."gtk-4.0".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/gtk-4.0";
        xdg.configFile."htop".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/htop";
        xdg.configFile."inkscape".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/inkscape";
        xdg.configFile."kitty".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/kitty";
        xdg.configFile."lazygit".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/lazygit";
        xdg.configFile."lf".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/lf";
        xdg.configFile."lnav".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/lnav";
        xdg.configFile."mimeapps.list".source =
          config.lib.file.mkOutOfStoreSymlink "${xdgconf}/mimeapps.list";
        xdg.configFile."niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "${SELF}/niri.kdl";
        xdg.configFile."niri/binds.kdl".source =
          config.lib.file.mkOutOfStoreSymlink "${SELF}/niri_binds.kdl";
        xdg.configFile."niri-session-manager/config.toml".source =
          config.lib.file.mkOutOfStoreSymlink "${SELF}/nirisess.toml";
        xdg.configFile."nwg-dock".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/nwg-dock";
        xdg.configFile."nwg-bar".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/nwg-bar";
        xdg.configFile."ncspot".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/ncspot";
        xdg.configFile."pistol".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/pistol";
        xdg.configFile."shellcheckrc".source =
          config.lib.file.mkOutOfStoreSymlink "${xdgconf}/shellcheckrc";
        xdg.configFile."spotify-flags.conf".source =
          config.lib.file.mkOutOfStoreSymlink "${xdgconf}/spotify-flags.conf";
        xdg.configFile."sqlite3".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/sqlite3";
        xdg.configFile."stylua".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/stylua";
        xdg.configFile."taplo".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/taplo";
        xdg.configFile."tmux".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/tmux";
        xdg.configFile."user-dirs.dirs".source =
          config.lib.file.mkOutOfStoreSymlink "${xdgconf}/user-dirs.dirs";
        xdg.configFile."user-dirs.locale".source =
          config.lib.file.mkOutOfStoreSymlink "${xdgconf}/user-dirs.locale";
        xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink "${SELF}/waybar";
        xdg.configFile."zathura".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/zathura";
        xdg.configFile."w3m".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/w3m";
        xdg.configFile."wluma".source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/wluma";
        xdg.configFile."xdg-terminals.list".source =
          config.lib.file.mkOutOfStoreSymlink "${xdgconf}/xdg-terminals.list";
      }
    )
  ];
}
