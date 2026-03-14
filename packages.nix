{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pv
    utf8proc
    reptyr
    # hardware
    kmon
    brightnessctl
    ddcutil
    ddcui
    usbutils
    lm_sensors
    pciutils
    udevil
    telegram-desktop # QT_SCALE_FACTOR = "1.75";
    file
    inkscape-with-extensions
    obs-cli
    android-tools
    hyperfine
    parallel
    procps
    ueberzugpp
    glow
    tree
    fd
    trash-cli
    fastfetch
    translate-shell
    remarshal # json2yaml...
    w3m
    chafa
    libnotify
    psmisc
    unrar
    unzip
    jq
    highlight
    imagemagick
    libwebp
  ];

}
