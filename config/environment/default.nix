{ pkgs, ... }: {
  environment.systemPackages = with pkgs;  [
    figma-linux
    # gnu
    parallel

    # programs
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

    # terminal
    lazygit
    tdrop
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
    zathura
    eza
    chafa
    tiv
    bat

    # utils
    libnotify
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
