{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    {
      environment.systemPackages = (
        with pkgs;
        [
          pv
          fwupd
          mesa-demos
          gpu-viewer
          vulkan-tools
          libva-utils # vainfo
          intel-gpu-tools # intel_gpu_top
          nvtopPackages.nvidia # nvtop
          shot-scraper
          tuir
          ddgr
          utf8proc
          reptyr
          # hardware
          mtools
          kmon
          brightnessctl
          ddcutil
          ddcui
          usbutils
          lm_sensors
          pciutils
          libxkbcommon
          # udevil
          telegram-desktop # QT_SCALE_FACTOR = "1.75";
          glib
          file
          inkscape-with-extensions
          # libreoffice-qt
          ticker
          tickrs
          cointop
          # poedit
          gettext
          intelephense
          obs-cli
          android-tools
          hyperfine
          parallel
          procps
          ueberzugpp
          glow
          tree
          silver-searcher
          fd
          trash-cli
          fastfetch
          translate-shell
          remarshal # json2yaml...
          w3m
          chafa
          tiv
          libnotify
          psmisc
          watchman
          # tree-sitter
          unrar
          unzip
          jq
          ffmpeg-full
          highlight
          hicolor-icon-theme
          imagemagick
          libwebp
          # debug
          # lldb
        ]
      );
    }
  ];
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "C.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];
  console.useXkbConfig = true;
  # console.font = "${pkgs.terminus_font}/share/consolefonts/ter-v32.psf.gz";
  # console.keyMap = lib.mkForce "us";
  # console.keyMap = "${pkgs.kbd}/share/keymaps/i386/qwerty/lt.map.gz";
  location.provider = lib.mkDefault "manual";
  location.latitude = 54.0;
  location.longitude = 25.0;
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "kalesnykas.aivaras@gmail.com";
  security.acme.defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";
  security.sudo.wheelNeedsPassword = false;
  security.pam.services.nginx.setEnvironment = false;
  nixpkgs.config.joypixels.acceptLicense = true;
  fonts.enableDefaultPackages = false;
  fonts.fontconfig.antialias = true;
  fonts.fontconfig.hinting.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.meslo-lg
    papirus-icon-theme
    # ttf
    # liberation_ttf
    # terminus_font_ttf
    #
    # terminus_font
    # lato
    #
    # nerd-fonts.symbols-only
    # nerd-fonts.dejavu-sans-mono
    # nerd-fonts.fira-mono
    # nerd-fonts.fira-code
    # powerline-fonts
    #
    # joypixels
    # font-awesome
    #
    # noto-fonts
    # noto-fonts-color-emoji
    # noto-fonts-monochrome-emoji

  ];
  # https://github.com/kamlendras/waybar-macos-sequoia/blob/main/config
  fonts.fontconfig.defaultFonts.serif = [
    "DejaVu Serif"
    # "Noto Color Emoji"
  ];
  fonts.fontconfig.defaultFonts.sansSerif = [
    "DejaVu Sans"
    # "Noto Color Emoji"
  ];
  fonts.fontconfig.defaultFonts.monospace = [
    "Hack Nerd Font Mono"
    "Liberation Mono"
    # "DejaVuSansM Nerd Font Mono"
    # "Noto Color Emoji"
  ];
  fonts.fontconfig.defaultFonts.emoji = [
    "Hack Nerd Font Mono"
    "Liberation Mono"
    # "Twitter Color Emoji"
    # "Noto Color Emoji"
    # "DejaVuSansM Nerd Font"
  ];
  environment.variables.MANPAGER = "less -R --use-color -Dd+r -Du+b";
  environment.variables.MANROFFOPT = "-P -c";
  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
    groff
    cht-sh
    tldr
    manix
  ];
  # environment.etc.nixos-docs.source = "${config.system.build.manual.manualHTML}/share/doc/nixos/";

  documentation = {
    enable = true;
    dev.enable = false;
    doc.enable = true;
    info.enable = true;
    nixos.enable = true;
    nixos.includeAllModules = true;

    # nixos.includeAllModules = true;
    man = {
      enable = true;
      generateCaches = false;
      man-db.enable = true;
      mandoc.enable = false;
      mandoc.settings.manpath = [ "/run/current-system/sw/share/man" ];
    };
  };
}
