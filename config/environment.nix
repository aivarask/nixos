{ pkgs, ... }:
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
{
  environment.variables.EDITOR = "nvim";
  environment.variables.XINITRC = "/etc/nixos/files/xinitrc";
  environment.shellAliases = {
    ".." = "cd ..";
    "..." = "../..";
    oras = "curl wttr.in/Vilnius";
    x = "startx";
    wol_pc = "wol b4:2e:99:61:09:cf";
  };
  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
      "/etc/nixos/bin"
    ];
  };
  environment.profiles = [
    "${pkgs.zig-shell-completions}"
    "${pkgs.zsh-completions}"
    "/etc/nixos"
  ];
  environment.systemPackages =
    xorgPackages
    ++ (with pkgs; [
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
      nicotine-plus
      slskd
      figma-linux
      parallel

      inotify-tools
      fswatch
      tremc
      mpv
      telegram-desktop
      gimp-with-plugins
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
    ]);
}
