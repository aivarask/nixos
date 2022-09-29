{ config, pkgs, ... }:
let
  bat-extras = with pkgs.bat-extras; [
    batdiff
    batgrep
    batman
    batwatch
    prettybat
  ];
  haskellPackages = with pkgs.haskellPackages; [
    # htoml
    # tomlcheck
    # htoml-megaparsec
  ];
  nodePackages = with pkgs.nodePackages; [
    bash-language-server
    vercel
    coc-rust-analyzer
    degit
    diagnostic-languageserver
    emoj
    eslint
    eslint_d
    fast-cli
    fixjson
    gulp
    js-beautify
    markdownlint-cli
    node2nix
    nodemon
    npm-check-updates
    patch-package
    pm2
    # pnpm
    prettier
    prisma
    pyright
    serve
    speed-test
    stylelint
    svelte-check
    svelte-language-server
    tailwindcss
    # typescript
    # typescript-language-server
    vim-language-server
    vscode-langservers-extracted
    write-good
    ts-node
  ];
  luajitPackages = with pkgs.luajitPackages; [
    inspect
    penlight
    std-_debug
  ];
  php80Packages = with pkgs.php80Packages; [ composer phpstan psalm ];
  php80Extensions = with pkgs.php80Extensions; [ xdebug ];
  gitAndTools = with pkgs.gitAndTools; [
    delta
    gh
    git-crypt
  ];
  python39Packages = with pkgs.python39Packages; [
    bcrypt
    debugpy
    pdf2image
    pdftotext
    pip
    pynvim
    # python-lsp-black
    # python-lsp-server
    tomlkit
  ];
  prismaSpecific = with pkgs; [
    prisma-engines
    prismaPackages."@prisma/language-server"
  ];
  playwrightDependencies = with pkgs; [
    icu66
    cairo
    google-chrome-dev
    firefox-bin
    webkitgtk
    pango
    dbus
    xorg.libX11
    xorg.libXrender
    dbus-glib
    wayland
    wayland-scanner
    wayland-utils
    wayland-protocols
    waylandpp
  ];
  rubyPackages = with pkgs.rubyPackages; [
    gemoji
  ];
in
{
  environment.systemPackages = with pkgs;
    rubyPackages ++
    playwrightDependencies ++
    prismaSpecific ++
    python39Packages ++
    gitAndTools ++
    bat-extras ++
    haskellPackages ++
    nodePackages ++
    luajitPackages ++
    php80Packages ++
    php80Extensions ++
    [
      ookla-speedtest
      speedtest-cli
      zsh-better-npm-completion
      luakit
      gtk3
      gtk3-x11
      zsh-autocomplete
      inetutils
      wiki-tui
      spotify
      spotify-tui
      certbot-full
      libwebp
      awscli2
      google-cloud-sdk
      patchelf
      # deno
      netlify-cli
      tdesktop
      xsel
      love
      remarshal
      lynx
      SDL2
      _7zz
      atool # Archive command line helper
      autofs5
      bandwhich
      bashdb
      bat
      bind
      brave
      cargo
      cargo-watch
      catdoc
      ccls
      chafa
      cheat
      chromium
      clang
      clang-tools
      clang_13
      cmake-format
      # cmake-language-server
      conky
      cypress
      dig
      dmenu
      dnsx
      drill
      duf
      dwm
      dwm-status
      emojione
      emote
      exa
      exiftool
      fasd
      fd
      feh
      ffmpeg
      ffmpegthumbnailer
      file
      firefox
      fzy
      gcc
      gdb
      gdu
      geoipWithDatabase
      git
      git-lfs
      gitlab
      gitlab-shell
      glib
      glibc
      libglibutil
      expat
      pango
      glow
      gnumake
      gnumeric
      google-chrome
      gruvbox-dark-gtk
      gruvbox-dark-icons-gtk
      hicolor-icon-theme
      highlight
      htop
      httpie
      icecast
      ifuse
      imagemagick
      jq
      kmon
      layan-gtk-theme
      lazygit
      lf
      libbacktrace
      libimobiledevice
      libplist
      libva-utils
      lm_sensors
      loc
      lua
      luaformatter
      luajit
      lxappearance
      manix
      mpc_cli
      mpd
      mpv
      neofetch
      nicotine-plus
      nimlsp
      # nix-du
      nix-index # + nix-locate
      nix-prefetch-github
      nix-template
      nix-tour
      nix-tree
      nixfmt
      nixpkgs-fmt
      nmap
      # nodejs_latest
      nodejs
      numlockx
      odt2txt
      pass
      pciutils
      perl
      perl534Packages.CPAN
      php
      pistol
      pkgs.nur.repos.mic92.hello-nur
      poppler
      poppler_utils
      postgresql
      pre-commit
      pscale
      psmisc
      pulsemixer
      puppeteer-cli
      # python39Full
      redshift
      remote-touchpad
      ripgrep
      rnix-lsp
      rust-analyzer
      rustc
      rustfmt
      rustup
      # rustup-toolchain-install-master
      sassc
      shellcheck
      shellharden
      shfmt
      slstatus
      soulseekqt
      spaceship-prompt
      sqlite
      sqlite-analyzer
      sqlite-interactive
      sqlite-jdbc
      sqlite-replication
      sqlite-utils
      sqlite-web
      ssh-chat
      st
      statix
      stripe-cli
      stylua
      sumneko-lua-language-server
      sxiv
      tabbed
      tiv
      # https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=tmux
      tmux
      tmuxPlugins.tmux-fzf
      tmuxPlugins.resurrect
      # toml2nix
      translate-shell
      trash-cli
      tree
      tree-sitter
      tremc
      udevil
      ueberzug
      unclutter-xfixes
      universal-ctags
      unoconv
      unrar
      unzip
      usbmuxd
      valgrind # debugtooling
      viber
      vim
      vim-vint
      w3m
      watchman
      wget
      whois
      wkhtmltopdf
      xclip
      xh
      xorg.xdpyinfo
      xorg.xev
      yaml-language-server
      yaml-merge
      yaml2json
      yamlfix
      yamllint
      yapf
      youtube-dl
      ytfzf
      zathura
      zsh
      zsh-completions
      zsh-fzf-tab
      zsh-nix-shell
    ];
}
