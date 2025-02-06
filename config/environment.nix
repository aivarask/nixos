# vim: nofoldenable
{ pkgs, lib, ... }:
{
  imports = [
    (lib.mkAliasOptionModule [ "env" ] [ "environment" ])
  ];
  environment.extraInit = ''
    		source /etc/nixos/profile
    	'';
  environment.variables.SELF = "/etc/nixos/";
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
    # "${pkgs.zig-shell-completions}"
    "/etc/nixos"
  ];
  environment.systemPackages = (
    with pkgs;
    [
      # hardware
      kmon
      brightnessctl
      usbutils
      lm_sensors
      pciutils
      libxkbcommon
      # udevil

      mpv
      telegram-desktop # QT_SCALE_FACTOR = "1.75";
      file
      dolphin
      blender
      figma-linux
      inkscape-with-extensions
      libreoffice-qt
      # gimp-with-plugins # bimp plugin fails
      krita
      #
      ticker
      tickrs
      cointop
      playwright-driver.browsers
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
      ueberzug
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
      lldb
    ]
  );
}
