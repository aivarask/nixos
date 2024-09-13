{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libreoffice-qt
    # nur.repos.running-grass.postman
    # --
    hyperfine
    xvkbd
    alsa-utils
    soulseekqt
    nicotine-plus
    slskd
    figma-linux
    parallel

    inotify-tools
    fswatch
    tremc
    mpv
    telegram-desktop
    gimp-with-plugins
    krita

    # hardware
    kmon
    brightnessctl
    usbutils
    lm_sensors
    # udevil
    pciutils
    libxkbcommon

    # terminal
    lazygit
    tdrop
    ueberzug
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
  ];
}
