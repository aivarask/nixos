{ pkgs, lib, ... }:
{
  imports = [
    {
      environment.systemPackages = (
        with pkgs;
        [
          shot-scraper
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
          # telegram-desktop # QT_SCALE_FACTOR = "1.75";
          glib
          file
          # blender
          # krita
          # figma-linux
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
          fontpreview
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
  time.timeZone = "Europe/Vilnius";
  users.defaultUserShell = pkgs.zsh;
  users.users."root" = {
    shell = pkgs.zsh;
    extraGroups = [ "http" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHEs8Ir7meX21p/xxIfwz/Z9vYDF0VCE29t4pML7iF/X root@dell"
      # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIANknZM5gmvqk6PlxOsiiPtmGEOH6HCIGs/YSarBXfEW root@pc"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINCfPZBHEBgGHptxSr6E4DvnztZQ8+MXvui0Bz9LJJM3 root@pc"
    ];
  };
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      # twitter-color-emoji
      # twemoji-color-font
      noto-fonts
      noto-fonts-color-emoji
      nerd-fonts.dejavu-sans-mono
      lato
      nerd-fonts.fira-mono
      nerd-fonts.fira-code
      powerline-fonts

      font-awesome
      noto-fonts-monochrome-emoji

    ];
    fontconfig = {
      defaultFonts = {
        emoji = [
          # "Twitter Color Emoji"
          "Noto Color Emoji"
          "DejaVuSansM Nerd Font"
        ];
        monospace = [
          "DejaVuSansM Nerd Font Mono"
          "Noto Color Emoji"
        ];
        sansSerif = [
          "DejaVu Sans"
          "Noto Color Emoji"
        ];
        serif = [
          "DejaVu Sans"
          "Noto Color Emoji"
        ];
      };
    };
  };
  # documentation
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
  documentation = {
    enable = true;
    dev.enable = true;
    doc.enable = true;
    info.enable = true;
    nixos = {
      enable = true;
      # includeAllModules = true;
    };
    man = {
      enable = true;
      generateCaches = true;
      man-db = {
        enable = true;
      };
      mandoc = {
        enable = false;
        settings.manpath = [ "/run/current-system/sw/share/man" ];
      };
    };
  };
}
