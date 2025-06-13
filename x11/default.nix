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
      home.file.".xinitrc".source = config.lib.file.mkOutOfStoreSymlink "${SELF}/x11/xinitrc";
      xdg.configFile."mimeapps.list".source =
        config.lib.file.mkOutOfStoreSymlink "${SELF}/x11/mimeapps.list";
      # home.file.".Xresources_".source = config.lib.file.mkOutOfStoreSymlink "${SELF}/x11/Xresources";
      # xresources.extraConfig = ''#include ".Xresources_"'';
      # xdg.configFile."gtk-3.0".source = config.lib.file.mkOutOfStoreSymlink "${SELF}/x11/gtk3";
      # xdg.dataFile."applications/alacritty.desktop".source =
      #   config.lib.file.mkOutOfStoreSymlink "/etc/nixos/xdg/alacritty.desktop";

      dconf.enable = false;
      dconf.settings = {
        # "org/gnome/desktop/interface".color-scheme = "prefer-dark";
        # "org/gnome/desktop/background" = {
        #   picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
        # };
      };

      home.packages = lib.mkMerge [
        [

          pkgs.lxappearance
          pkgs.xcursor-pro
          pkgs.gnome-themes-extra
          # pkgs.orchis-theme
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

      # home.pointerCursor.x11.enable = true;
      # home.pointerCursor.name = "${cursor-name}";
      # home.pointerCursor.size = 64;
      # home.pointerCursor.package = package;

      # qt.enable = false;
      # qt.platformTheme.name = "qtct";
      # qt.style.name = "kvantum";

      # xdg.configFile."Kvantum/ArcDark".source = "${pkgs.arc-kde-theme}/share/Kvantum/ArcDark";
      # xdg.configFile."Kvantum/Gruvbox-Dark-Brown".source = "${pkgs.gruvbox-kvantum}/share/Kvantum/Gruvbox-Dark-Brown";
      # xdg.configFile."Kvantum/kvantum.kvconfig".text = "[General]\ntheme=Gruvbox-Dark-Brown";

      # environment.systemPackages = with pkgs; [
      #   xdg-utils
      #   # kdePackages.dolphin # gtk2
      # ];
      # xdg.portal.enable = true;
      # xdg.portal.extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
      # xdg.portal.config.common.default = "kde";
      # xdg.mime.enable = true;
      # https://discourse.nixos.org/t/creating-symlinks-in-nixos/50280/3
      # xdg.terminal-exec.enable = true;
      # xdg.terminal-exec.settings.default = [ "kitty.desktop" ];
      # environment.variables.XDG_TERMINAL = "${pkgs.kitty}/bin/kitty";
      # environment.variables.XDG_SYSTEM_MONITOR = "${pkgs.resources}/bin/resources";
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

      services.libinput.mouse.accelSpeed = "+0.5";
      services.libinput.touchpad.naturalScrolling = true;
      services.libinput.touchpad.accelSpeed = "+0.5";
      services.xserver.enable = true;
      services.xserver.autorun = false;
      services.xserver.exportConfiguration = true;
      services.xserver.resolutions = lib.mkIf false [
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
      # services.xserver.upscaleDefaultCursor = true;
      services.xserver.xkb.model = "pc104";
      services.xserver.xkb.layout = "us,lt";
      services.xserver.xkb.options = "grp:menu_toggle"; # localectl list-x11-keymap-options
      # services.xserver.xkb.variant = "qwerty"; # localectl list-x11-keymap-variants
      services.xserver.dpi = lib.mkDefault null;
      # services.xserver.tty = 7;
      services.xserver.displayManager.startx.enable = true;
      services.displayManager.autoLogin.enable = false;
      services.displayManager.autoLogin.user = "aiva";

      services.xserver.displayManager.startx.generateScript = false;

    };
}
