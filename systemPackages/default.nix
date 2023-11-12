{pkgs, ...}: {
  imports = [
    ./cRelated.nix
    ./gitAndTools.nix
    ./gitAndTools.nix
    ./goRelated.nix
    ./gtkRelated.nix
    ./haskellPackages.nix
    ./luaPackages.nix
    ./nixRelated.nix
    ./nodePackages.nix
    ./phpRelated.nix
    ./pythonPackages.nix
    ./rustRelated.nix
    ./shells.nix
    ./sqlRelated.nix
    ./suckless.nix
    ./xorgRelated.nix
  ];
  environment.systemPackages = with pkgs; [
    # ISSUE: Check if typescript and svelte workspace/WillRename works correctly in vscode
    # https://nixos.wiki/wiki/VSCodium
    (vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = with vscode-extensions;
        [
          bbenoist.nix
          ms-python.python
          ms-azuretools.vscode-docker
          ms-vscode-remote.remote-ssh
          svelte.svelte-vscode
          # vscodevim.vim
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "remote-ssh-edit";
            publisher = "ms-vscode-remote";
            version = "0.47.2";
            sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
          }
        ];
    })
    hyperfine
    bun
    inotify-tools
    scrot
    xorg.xwd
    CuboCore.coreshot
    usbutils
    powertop
    powerstat
    s-tui
    stress
    firestarter

    taskwarrior
    taskwarrior-tui

    libbs2b
    ladspaPlugins
    phetch
    tilda

    ethtool
    wol
    brave
    webkitgtk
    playwright
    prisma-engines
    # prismaPackages."@prisma/language-server"
    # --
    silver-searcher
    SDL2
    _7zz
    atool
    autofs5
    bandwhich
    bashdb
    bat
    bind
    bitwig-studio
    brightnessctl
    catdoc
    certbot-full
    chafa
    cheat
    conky
    cypress
    dig
    dnsx
    drill
    duf
    emojione
    emote
    eza # exa replacement
    exiftool
    expat
    expect
    fasd
    fd
    feh
    ffmpeg
    ffmpegthumbnailer
    file
    fontpreview
    fzy
    geoipWithDatabase
    # gcc
    gdb
    gdu
    glib
    glibc
    glow
    gnumake
    gnumeric
    hicolor-icon-theme
    highlight
    htop
    httpie
    icecast
    iftop
    ifuse
    imagemagick
    inetutils
    jq
    kmon
    lesspipe
    lf
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
    ltrace
    lxappearance
    lynx
    marksman
    mkcert
    mono
    mpc_cli
    mpd
    mpv
    neofetch
    neovim-remote
    nginx
    nicotine-plus
    nmap
    nssTools
    odt2txt
    ookla-speedtest
    openssl
    pango
    pass
    patchelf
    pciutils
    perl
    perl538Packages.CPAN
    pistol
    poppler
    poppler_utils
    pre-commit
    pscale
    psmisc
    pulsemixer
    puppeteer-cli
    redshift
    remarshal
    remote-touchpad
    ripgrep
    rubyPackages.gemoji
    sassc
    shellcheck
    shellharden
    shfmt
    sl
    soulseekqt
    spaceship-prompt
    speedtest-cli
    ssh-chat
    tdesktop
    tiv
    tmux
    tmuxPlugins.resurrect
    tmuxPlugins.tmux-fzf
    translate-shell
    trash-cli
    tree
    tree-sitter
    tremc
    udevil
    ueberzug
    universal-ctags
    unrar
    unzip
    usbmuxd
    vim
    w3m
    watchman
    wget
    whois
    wiki-tui
    yamllint
    yapf
    yarn
    youtube-dl
    ytfzf
    zathura
    zsh
  ];
}
