{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pv
    fwupd
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
  ];

}
