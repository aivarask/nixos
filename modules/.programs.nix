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
          {
            home.packages = with pkgs; [
              reaper
              surge-xt
              vital
            ];
          }
        ];

        home.packages = with pkgs; [
          roomeqwizard
          xdg-terminal-exec
          xdg-launch
          sqlitebrowser
          gcr
          inkscape-with-extensions
          lnav
          htop
          gtk3
          gtk4
          nautilus
          thunar
          thunar-volman
          tumbler
          kitty
          gtk-doc
          vimpager
          bitwarden-cli
          # bitwarden-desktop
          spotify
          ncspot
          lingot # guitar tuner
          mixxx
          #################### from sway
          clipman
          mcat
          keyd
          wshowkeys
          libinput
          # sway-overfocus
          showmethekey
          fuzzel
          x11perf
          waypipe
          ydotool
          hyprmagnifier
          bemoji
          catt
          eww
          gammastep
          glib-networking
          grim
          ifwifi
          kanshi
          localsend
          # mako
          miraclecast
          papirus-icon-theme
          pavucontrol
          pipewire
          playerctl
          python3
          kdotool

          ookla-speedtest
          iperf3
          traceroute

          # sway
          swayidle
          swaylock
          swayr
          waybar
          wayvnc
          wdisplays
          wev
          wtype
          evtest
          # wireplumber
          wl-clipboard
          wlr-randr
          wttrbar
          xcursor-pro
          xdg-utils # https://www.freedesktop.org/wiki/Software/xdg-utils/
          xdg-terminal-exec
          xdg-user-dirs
          xdg-user-dirs-gtk
          # xdg-desktop-portal-wlr
          xkeyboard-config
          xkbcomp
          xmodmap
          setxkbmap
          # https://github.com/swaywm/sway/wiki/Useful-add-ons-for-sway#bar-content-generators

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
