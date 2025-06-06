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
      home.file.".Xresources_extra".source =
        config.lib.file.mkOutOfStoreSymlink "${SELF}/x11/.Xresources_extra";
      xresources.extraConfig = ''#include ".Xresources_extra"'';

      # home.pointerCursor.x11.enable = true;
      # home.pointerCursor.gtk.enable = true;
      # home.pointerCursor.name = "Vanilla-DMZ";
      # home.pointerCursor.package = pkgs.vanilla-dmz;
      # home.pointerCursor.size = lib.mkDefault 64;

      gtk.enable = true;
      gtk.theme.name = "Adwaita-dark";
      gtk.theme.package = pkgs.gnome-themes-extra;
      home.packages = with pkgs; [
        gnome-themes-extra
        layan-gtk-theme
        # gruvbox-dark-gtk
        # gruvbox-dark-icons-gtk
      ];
      qt.enable = true;
      qt.platformTheme = "gnome";
      qt.style = "adwaita-dark";
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
      services.xserver.imwheel.enable = true;
      services.xserver.imwheel.rules = {
        "^(telegram-desktop|chromium|brave|firefox).*" = ''
          None, Up, Button4, 2
          None, Down, Button5, 2
          Shift_L,   Up,   Shift_L|Button4, 2
          Shift_L,   Down, Shift_L|Button5, 2
          Control_L, Up,   Control_L|Button4
          Control_L, Down, Control_L|Button5
        '';
      };
    };
}
