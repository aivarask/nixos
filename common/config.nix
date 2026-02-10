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
  location.provider = lib.mkDefault "manual";
  location.latitude = 54.0;
  location.longitude = 25.0;
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "kalesnykas.aivaras@gmail.com";
  security.acme.defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";
  security.sudo.wheelNeedsPassword = false;
  security.pam.services.nginx.setEnvironment = false;
  nixpkgs.config.joypixels.acceptLicense = true;
}
