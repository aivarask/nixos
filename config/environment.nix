{ pkgs, lib, ... }:
{
  imports = [
    (lib.mkAliasOptionModule [ "env" ] [ "environment" ])
  ];

  environment.variables.SELF = "/etc/nixos";
  environment.variables.EDITOR = "vim";
  # environment.pathsToLink = [
  #   "/share/zsh"
  #   "/share/fish"
  # ];
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
    PATH = [
      "${XDG_BIN_HOME}"
      "/etc/nixos/bin"
    ];
  };
  environment.profiles = [
    "/etc/nixos"
  ];
  environment.systemPackages = (
    with pkgs;
    [
      # hardware
      mtools
      kmon
      brightnessctl
      usbutils
      lm_sensors
      pciutils
      libxkbcommon
      # udevil

      telegram-desktop # QT_SCALE_FACTOR = "1.75";
      file
      # blender
      figma-linux
      inkscape-with-extensions
      # libreoffice-qt
      # gimp-with-plugins # bimp plugin fails
      krita
      #
      ticker
      tickrs
      cointop
      poedit
      gettext
      intelephense
      obs-cli
      difftastic
      android-tools

      # https://nixos.wiki/wiki/MTP
      gdu
      duf
      jmtpfs
      mtpfs
      go-mtpfs

      glib # gio trash
      ffuf
      hyperfine
      parallel
      inotify-tools
      fswatch

      # terminal
      tdrop
      procps
      guake
      ueberzugpp
      cheat
      feh
      glow
      scrot
      tokei # loc unmaintained
      tree
      fd
      ripgrep
      trash-cli
      neofetch
      translate-shell
      remarshal # json2yaml...
      w3m
      chafa
      tiv

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
      # lldb
    ]
  );
}
