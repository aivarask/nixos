# vim:foldlevel=4
{
  pkgs,
  lib,
  config,
  ...
}:
{
  services.caddy = {
    enable = false;
  };
  services.geoclue2 = {
    enable = true;
  };
  services.kmscon = {
    enable = lib.mkDefault true;
    autologinUser = lib.mkDefault "root";
    useXkbConfig = true;
    hwRender = lib.mkDefault true;
    extraConfig = ''
      font-dpi=${toString config.services.xserver.dpi}
      font-size=${if config.networking.hostName == "dell" then "10" else "12"}
    '';
  };
  services.libinput = {
    mouse = {
      accelSpeed = "+0.5";
    };
    touchpad = {
      naturalScrolling = true;
      accelSpeed = "+0.5";
    };
  };
  services.locate = {
    enable = true;
  };
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      X11Forwarding = true;
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "yes";
    };
  };
  services.redshift = {
    enable = true;
    temperature.day = 6500;
    temperature.night = 5500;
  };
  services.transmission = {
    enable = true;
    openPeerPorts = true;
    settings = {
      watch-dir = "/var/lib/transmission/watch-dir";
      watch-dir-enabled = true;
    };
  };
  services.unclutter = {
    # unclutter-xfixes
    enable = false;
    timeout = 1;
    extraOptions = [
      # "noevents"
      # "grab"
      # "fork"
    ];
  };
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    windowManager.awesome.enable = lib.mkDefault false;
    windowManager.dwm.enable = lib.mkDefault true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 50;
    enableCtrlAltBackspace = true;
    enableTCP = true;
    upscaleDefaultCursor = true;
    xkb = {
      layout = "us,lt";
      options = "grp:menu_toggle"; # localectl list-x11-keymap-options
      variant = "qwerty"; # localectl list-x11-keymap-variants
    };
    tty = null;
    # https://wiki.archlinux.org/title/Multihead
    xrandrHeads = [ ];
    imwheel = {
      enable = true;
      rules = {
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
    # xdpyinfo | grep -E 'dimensions|resolution'
    # 15.6" 3840x2160 345x194
    # 27" 3840x2160 597x336
    dpi =
      {
        dell = 282;
        # pc = 163;
        pc = builtins.ceil (90 * 2.5);
      }
      ."${config.networking.hostName}" or 144;
  };
  services.maddy = {
    enable = true;
    primaryDomain = "localhost";
    ensureAccounts = [
      "test@localhost"
      "ab@localhost"
      "test@test.ekolangas.lt"
    ];
    ensureCredentials = {
      "test@localhost".passwordFile = "${pkgs.writeText "postmaster" "l"}";
      "ab@localhost".passwordFile = "${pkgs.writeText "postmaster" "l"}";
      "test@test.ekolangas.lt".passwordFile = "${pkgs.writeText "postmaster" "l"}";
    };
  };
  services.dwm-status = {
    enable = true;
    extraConfig = ''
      separator = " "

      [audio]
      # backend = "pulseaudio" # separate branch without flake
      # control = "Master Playback Volume"
      mute = "MUTE"
      template = "{ICO}{VOL}"
      icons = ["🔈", "🔉", "🔊"]

      [backlight]
      device = "intel_backlight"
      template = "{ICO}{BL}"
      icons = ["🔅", "🔆", "😎"]

      [battery]
      charging = "🔌"
      discharging = "🔦"
      enable_notifier = true
      no_battery = ""
      notifier_critical = 10
      notifier_levels = [2, 5, 10, 15, 20]
      separator = ""
      icons = ["🪫", "🔋", "🔋"]

      [cpu_load]
      template = "🤖 {CL1} {CL5} {CL15}"
      update_interval = 20

      [network]
      no_value = "🌑"
      template = "📶{ESSID}"
      # template = "🌐{IPv4} 📶{ESSID}"

      [time]
      format = "📆%m-%d %H:%M"
      update_seconds = false
    '';
    order = lib.mkMerge [
      # [ "audio" ]
      (lib.mkIf (config.networking.hostName == "dell") [
        # "audio"
        "backlight"
        "battery"
      ])
      [
        # "cpu_load"
        "network"
        "time"
      ]
    ];
  };
}
