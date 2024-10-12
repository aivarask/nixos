{
  pkgs,
  lib,
  config,
  ...
}:
{
  services.blueman = {
    # Device B8:53:AC:C2:7F:24 Aivaras’s iPhone
    # Device AC:90:85:C6:DA:FD AirPods
    # Device D4:11:A3:98:B4:88 Galaxy A50
    enable = lib.mkDefault false;
  };
  services.caddy = {
    enable = false;
  };
  services.dnscrypt-proxy2 = {
    enable = true;
  };
  services.geoclue2 = {
    enable = lib.mkDefault true;
  };
  services.kmscon = {
    enable = lib.mkDefault true;
    autologinUser = lib.mkDefault "root";
    useXkbConfig = true;

    hwRender = lib.mkDefault true;
    extraConfig = ''
      font-size=${if config.networking.hostName == "dell" then "10" else "6"}
      font-dpi=${toString config.services.xserver.dpi}
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
  services.pipewire = {
    enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };
  services.redshift = {
    enable = true;
    temperature.day = 6500;
    temperature.night = 4500;
  };
  networking.firewall.allowedTCPPorts = [
    9091
    51413
  ];
  services.transmission = {
    enable = false;
    settings = {
      watch-dir = "/var/lib/transmission/watch-dir";
      watch-dir-enabled = true;

    };
  };
  services.unclutter = {
    enable = true;
    timeout = 1;
    extraOptions = [
      # "noevents"
      # "grab"
      # "fork"
    ];
  };
  services.xserver = {
    enable = true;
    windowManager.awesome.enable = lib.mkDefault false;
    windowManager.dwm.enable = lib.mkDefault true;
    displayManager.startx.enable = true;
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
    # LINKS:
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
        pc = 163;
      }
      ."${config.networking.hostName}" or 144;
  };
  environment.systemPackages = with pkgs; [
    pulsemixer
    mpc_cli
  ];
  services.mpd = {
    enable = true;
    user = "root";
    group = "wheel";
    playlistDirectory = /etc/nixos/files/playlist;
    # network.listenAddress = "any";
    startWhenNeeded = true;
    extraConfig = ''
      auto_update "yes"
      music_directory "/var/music"
      audio_output {
        type "pulse"
        name "Pulseaudio"
        server "0.0.0.0"
      }
      playlist_plugin {
        name "m3u"
        enabled "true"
      }
      # bind_to_address "0.0.0.0:6600"
      # bind_to_address "/var/lib/mpd/socket"
      bind_to_address "/run/mpd/socket"
    '';
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
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedOptimisation = true;
    recommendedTlsSettings = true;
    # recommendedGzipSettings = true;
    # recommendedZstdSettings = true;
    # recommendedBrotliSettings = true;
  };
  systemd.services.nginx.serviceConfig = {
    SupplementaryGroups = [ "shadow" ];
    NoNewPrivileges = lib.mkForce false;
    PrivateDevices = lib.mkForce false;
    ProtectHostname = lib.mkForce false;
    ProtectKernelTunables = lib.mkForce false;
    ProtectKernelModules = lib.mkForce false;
    RestrictAddressFamilies = lib.mkForce [ ];
    LockPersonality = lib.mkForce false;
    MemoryDenyWriteExecute = lib.mkForce false;
    RestrictRealtime = lib.mkForce false;
    RestrictSUIDSGID = lib.mkForce false;
    SystemCallArchitectures = lib.mkForce "";
    ProtectClock = lib.mkForce false;
    ProtectKernelLogs = lib.mkForce false;
    RestrictNamespaces = lib.mkForce false;
    SystemCallFilter = lib.mkForce "";
  };
  services.dwm-status = {
    enable = true;
    extraConfig = ''
      separator = " "

      [audio]
      # backend = "pulseaudio" # separate branch without flake
      control = "Master"
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
      template = "🌐{IPv4} 📶{ESSID}"

      [time]
      format = "📆%m-%d %H:%M"
      update_seconds = false
    '';
    order = lib.mkMerge [
      # [ "audio" ]
      (lib.mkIf (config.networking.hostName == "dell") [
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
