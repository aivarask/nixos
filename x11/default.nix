{
  hm =
    {
      SELF,
      config,
      pkgs,
      lib,
      ...
    }:
    {

      home.file.".xinitrc".source = lib.mkDefault (
        config.lib.file.mkOutOfStoreSymlink "${SELF}/x11/xinitrc"
      );
      # home.file.".xinitrc".source =
      #   (lib.mkIf (config.home.username != "root")) config.lib.file.mkOutOfStoreSymlink
      #     "${SELF}/users/xinitrc";
      xdg.configFile."mimeapps.list".source =
        config.lib.file.mkOutOfStoreSymlink "${SELF}/x11/mimeapps.list";
      home.file.".Xresources".source = config.lib.file.mkOutOfStoreSymlink "${SELF}/x11/Xresources";
      # xresources.extraConfig = ''#include ".Xresources_"'';
      # xdg.configFile."gtk-3.0".source = config.lib.file.mkOutOfStoreSymlink "${SELF}/x11/gtk3";

      dconf.enable = false;
      dconf.settings = {
        # "org/gnome/desktop/interface".color-scheme = "prefer-dark";
        # "org/gnome/desktop/background" = {
        #   picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
        # };
      };

      home.packages = lib.mkMerge [
        [
          #   xdg-utils
          pkgs.nautilus
          # pkgs.kdePackages.dolphin
          pkgs.lxappearance
          pkgs.vanilla-dmz
          pkgs.xcursor-pro
          pkgs.gnome-themes-extra
          pkgs.orchis-theme
          # pkgs.gtk-engine-murrine
          # qt
          # pkgs.falcon
          # pkgs.qutebrowser
          # pkgs.minitube
          # pkgs.adwaita-qt
          # pkgs.adwaita-qt6
          # pkgs.libsForQt5.qt5ct
          # pkgs.libsForQt5.qtstyleplugin-kvantum
          # pkgs.gruvbox-kvantum
        ]
      ];

      services.syncthing.enable = true;
      services.syncthing.settings.folders."sync".path = "${config.home.homeDirectory}/sync";

      xdg.enable = true;
      # xdg.configFile."user-dirs.dirs".source =
      #   config.lib.file.mkOutOfStoreSymlink "$SELF/x11/user-dirs.dirs";
      xdg.userDirs.enable = true;
      xdg.portal.enable = true;
      xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      xdg.portal.config.common.default = "gtk";
      xdg.mime.enable = true;

      gtk.gtk3.bookmarks = [
        "file://${config.xdg.userDirs.documents}"
        "file://${config.xdg.userDirs.download}"
        "file://${config.services.syncthing.settings.folders."sync".path}"
        # "file://${config.varden.flakeDir}"
      ];
    };
  default =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {

      environment.systemPackages =
        with pkgs;
        [
          yad
          zenity
          # https://wiki.archlinux.org/title/List_of_applications/Utilities#GUI/TUI_prompts
          # https://help.gnome.org/users/zenity/stable/index.html.en
          # xprop | grep WM_CLASS
          # xprop | grep WM_NAME
          xcompmgr
          xdotool
          xsel
          xclip
          xnotify
          sxiv
          numlockx
          xautomation
          xbindkeys
          xvkbd
          wmctrl
          xpra # https://github.com/Xpra-org/xpra/blob/master/docs/Usage/README.md
          read-edid
          picom
          devilspie2 # https://web.archive.org/web/20160304040823/http://foosel.org/linux/devilspie
          xdo
        ]
        ++ (with pkgs.xorg; [
          xcursorthemes
          libXcursor
          libXext
          xbacklight
          xorgserver
          xdpyinfo
          xev
          xmodmap
          xmessage
          transset
          xwininfo
          xwd
        ]);

      services.libinput.mouse.accelSpeed = "flat";
      services.libinput.touchpad.naturalScrolling = true;
      services.libinput.touchpad.accelSpeed = "+0.5";
      services.xserver.enable = true;
      services.xserver.autorun = true;
      services.xserver.exportConfiguration = true;
      services.xserver.resolutions = lib.mkIf true [
        {
          x = 3840;
          y = 2160;
        }
        {
          x = 1920;
          y = 1080;
        }
      ];
      services.xserver.config = '''';
      services.xserver.displayManager.xpra.enable = false;
      services.xserver.windowManager.awesome.enable = lib.mkDefault false;
      services.xserver.windowManager.dwm.enable = lib.mkDefault true;
      services.xserver.autoRepeatDelay = 200;
      services.xserver.autoRepeatInterval = 50;
      services.xserver.enableCtrlAltBackspace = true;
      services.xserver.enableTCP = true;
      services.xserver.xkb.model = "pc105";
      services.xserver.xkb.layout = "us,lt";
      services.xserver.xkb.options = "grp:menu_toggle"; # localectl list-x11-keymap-options
      # services.xserver.xkb.options = "grp:alt_shift_toggle"; # localectl list-x11-keymap-options
      services.xserver.xkb.variant = ""; # localectl list-x11-keymap-variants
      services.xserver.dpi = lib.mkDefault null;
      # services.xserver.tty = 7;
      services.displayManager.autoLogin.enable = false;
      services.displayManager.autoLogin.user = "aiva";
      services.xserver.displayManager.startx.enable = true;
      services.xserver.displayManager.startx.generateScript = false;

      # services.xserver.upscaleDefaultCursor = true;
    };
}
