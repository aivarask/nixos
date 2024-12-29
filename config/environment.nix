# vim: nofoldenable
{ pkgs, lib, ... }:
{
  imports = [
    (lib.mkAliasOptionModule [ "env" ] [ "environment" ])
  ];
  environment.extraInit = '''';
  environment.variables.SELF = "/etc/nixos/";
  environment.variables.XINITRC = "/etc/nixos/config/files/xinitrc";
  environment.variables.EDITOR = "vim";
  environment.shellAliases = {
    ".." = "cd ..";
    "..." = "../..";
    x = "startx";
    wol_pc = "wol b4:2e:99:61:09:cf";
  };
  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_BIN_HOME = "$HOME/.local/bin";
    PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
    PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = 1;
    PATH = [
      "${XDG_BIN_HOME}"
      "/etc/nixos/bin"
    ];
  };
  environment.profiles = [
    "${pkgs.zig-shell-completions}"
    "/etc/nixos"
  ];
  environment.systemPackages = (
    with pkgs;
    let
      xorgPackages = with pkgs.xorg; [
        xbacklight
        xorgserver
        xdpyinfo
        xev
        xmodmap
        xmessage
        transset
        xwininfo
        xwd
      ];
    in
    xorgPackages
    ++ [
      file
      dolphin
      blender
      ticker
      tickrs
      cointop
      inkscape-with-extensions
      playwright-driver.browsers
      poedit
      gettext
      # intelephense
      obs-cli
      difftastic
      tuir
      josm
      merkaartor
      android-tools
      # https://nixos.wiki/wiki/MTP
      jmtpfs
      mtpfs
      go-mtpfs
      # xorg
      xcompmgr
      xdotool
      xsel
      xclip
      sxiv
      unclutter-xfixes
      numlockx
      xautomation
      xbindkeys

      glib # gio trash
      ffuf
      libreoffice-qt
      # nur.repos.running-grass.postman
      # --
      hyperfine
      xvkbd
      soulseekqt
      nicotine-plus # GDK_SCALE = "2";
      slskd
      figma-linux
      parallel

      inotify-tools
      fswatch
      tremc
      mpv
      telegram-desktop # QT_SCALE_FACTOR = "1.75";
      # gimp-with-plugins
      # krita

      # hardware
      kmon
      brightnessctl
      usbutils
      lm_sensors
      # udevil
      pciutils
      libxkbcommon

      # terminal
      tdrop
      ueberzug
      ueberzugpp
      ollama
      tilda
      cheat
      feh
      gdu
      duf
      glow
      scrot
      httpie
      lf
      loc
      tree
      fd
      ripgrep
      trash-cli
      neofetch
      ookla-speedtest
      translate-shell
      remarshal # json2yaml...
      w3m
      chafa
      tiv
      bat

      # utils
      libnotify
      psmisc # fuser killall prtstat pslog pstree peekfd
      watchman
      tree-sitter
      unrar
      unzip
      jq
      ffmpeg
      highlight
      hicolor-icon-theme
      imagemagick
      libwebp
      # debug
      lldb
    ]
  );
}
