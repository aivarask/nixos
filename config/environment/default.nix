{ pkgs, ... }: {
  environment.systemPackages = with pkgs;  [
    # programs
    brave
    tremc
    mpv
    telegram-desktop

    # hardware
    kmon
    brightnessctl
    usbutils
    lm_sensors
    udevil
    pciutils
    libxkbcommon

    # network
    ethtool
    wol
    bind
    drill
    dig
    dnsx
    geoipWithDatabase
    mkcert
    nmap
    wget
    whois
    inetutils
    openssl
    nss

    # terminal
    libnotify
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
    remote-touchpad
    remarshal # json2yaml...
    w3m
    zathura
    eza
    chafa
    tiv
    bat

    # utils
    psmisc # fuser killall prtstat pslog pstree peekfd
    inotify-tools # inotifywait inotifywatch
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
  ];
}
