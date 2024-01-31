{ pkgs, ... }:
with pkgs; let
  bench = [
    hyperfine
  ];

in
{
  environment.systemPackages = with pkgs;  [

    # hardware
    brightnessctl
    usbutils

    # network
    ethtool
    wol
    bind
    drill
    dig
    dnsx
    geoipWithDatabase

    # browser
    brave

    # terminal
    inotify-tools
    scrot
    tilda
    bat
    duf
    cheat
    fd
    feh
    gdu
    jq
    glow
    httpie
    lf

    # --
    ffmpeg
    ffmpegthumbnailer
    fzy
    glibc
    gnumeric
    hicolor-icon-theme
    highlight
    imagemagick
    inetutils
    kmon
    libbacktrace
    libglibutil
    libimobiledevice
    libnotify
    libplist
    libuv
    libva-utils
    libwebp
    libxkbcommon
    lm_sensors
    loc
    mkcert
    mpv
    neofetch
    nmap
    nssTools
    odt2txt
    ookla-speedtest
    openssl
    pango
    patchelf
    pciutils
    perl
    perl538Packages.CPAN
    poppler
    poppler_utils
    psmisc
    remarshal
    remote-touchpad
    ripgrep
    sassc
    tiv
    translate-shell
    trash-cli
    tree
    tree-sitter
    tremc
    udevil
    unrar
    unzip
    usbmuxd
    watchman
    wget
    whois
    # pistol
    pistol
    w3m
    zathura
    eza # exa replacement
    chafa
  ];
}
