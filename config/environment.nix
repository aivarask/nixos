{ pkgs, lib, ... }:
{
  environment.systemPackages = (
    with pkgs;
    [
      tuir
      ddgr
      utf8proc
      reptyr
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
      gimp-with-plugins # bimp plugin fails
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
