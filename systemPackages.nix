{ pkgs, ... }:
let
  bat-extras = with pkgs.bat-extras; [
    batgrep
    batman
    batpipe
    batwatch
    batdiff
    prettybat
  ];
  haskellPackages = with pkgs.haskellPackages; [
    # htoml
    # tomlcheck
    # htoml-megaparsec
  ];
  nodeList = with pkgs.nodePackages_latest; [
    # emmet_ls
    gulp
    pyright
    npm
    bash-language-server
    vercel
    coc-rust-analyzer
    degit
    diagnostic-languageserver
    emoj
    # eslint
    # eslint_d
    fast-cli
    fixjson
    gulp
    js-beautify
    markdownlint-cli
    mermaid-cli
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
    typescript
    typescript-language-server
    vim-language-server
    vscode-langservers-extracted
    write-good
    ts-node
  ];
  luajitPackages = with pkgs.luajitPackages; [
    busted # https://lunarmodules.github.io/busted/
    inspect # https://github.com/kikito/inspect.lua
    penlight # https://github.com/lunarmodules/Penlight
    std-_debug # https://lua-stdlib.github.io/_debug/
    plenary-nvim # https://github.com/nvim-lua/plenary.nvim
  ];
  php80Packages = with pkgs.php80Packages; [ composer phpstan psalm ];
  php80Extensions = with pkgs.php80Extensions; [ xdebug ];
  gitAndTools = with pkgs.gitAndTools; [ delta gh git-crypt ];
  prismaSpecific = with pkgs; [
    prisma-engines
    prismaPackages."@prisma/language-server"
  ];
  playwrightDependencies = with pkgs; [
    playwright
    playwright.browsers
    google-chrome-dev
    firefox-bin
    webkitgtk
  ];
  rubyPackages = with pkgs.rubyPackages; [ gemoji ];
  xorgP = with pkgs.xorg; [
    # https://nixos.wiki/wiki/Using_X_without_a_Display_Manager
    xbacklight
    xorgserver
    xf86inputevdev
    xf86inputsynaptics
    xf86inputlibinput
    libX11
    libXrender
    xdpyinfo
    xev
    xmodmap
    xmessage
  ];
  myPython = with pkgs.python3Packages; [
    # bcrypt
    # debugpy
    # pdf2image
    # pdftotext
    pip
    pynvim
    # python-lsp-black
    python-lsp-server
    # tomlkit
    flake8
    autopep8
    setuptools
    wheel
    # from overlay
    inotify_simple
    tuimoji
  ];

  # https://github.com/nix-community/awesome-nix#command-line-tools
  nixRelated = with pkgs; [
    # https://github.com/nix-community/awesome-nix#development
    alejandra
    # comma
    deadnix
    manix

    # nixfmt
    # nixpkgs-fmt
    # nixpkgs-hammering
    # nix-alien
    # nix-diff
    # nix-du
    nix-index
    # nix-init
    nix-prefetch
    nix-tree
    nurl
    # nvd
    statix

    # https://github.com/nix-community/awesome-nix#development
    rnix-lsp
    nil
    niv

    # -- OTHER --
    # nix-prefetch-git
    # nix-prefetch-github
    # nix-template
    # nix-tour
  ];

  fzfTools = with pkgs; [ silver-searcher ];
in
{
  environment.systemPackages = with pkgs;
    nixRelated
    ++ fzfTools
    ++ xorgP
    # ++ over
    ++ rubyPackages
    ++ playwrightDependencies
    ++ prismaSpecific
    ++ myPython
    ++ gitAndTools
    ++ bat-extras
    ++ haskellPackages
    ++ nodeList
    ++ luajitPackages
    ++ php80Packages
    ++ php80Extensions
    ++ [
      libnotify
      fontpreview
      xdotool
      marksman

      lesspipe
      emojipick
      sl
      libuv
      st
      slstatus
      neovim-remote
      # pkgs.nur.repos.mic92.hello-nur
      iftop
      python3Full

      openssl
      yarn
      brightnessctl
      libxkbcommon
      mkcert
      nssTools
      # http://tidalcycles.org/
      bitwig-studio
      # ---
      ookla-speedtest
      speedtest-cli
      luakit
      gtk3
      gtk3-x11
      inetutils
      wiki-tui
      # spotify
      # spotify-tui
      certbot-full
      libwebp
      nginx
      # awscli2
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
      glab
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
      # FIX: build erro
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
      ltrace
      # lua
      luaformatter
      luajit
      lxappearance
      mono
      mpc_cli
      mpd
      mpv
      neofetch
      nicotine-plus
      nimlsp
      nmap
      # nodejs_latest
      nodejs-19_x
      numlockx
      odt2txt
      pass
      pciutils
      perl
      perl534Packages.CPAN
      php
      pistol
      poppler
      poppler_utils
      postgresql
      pre-commit
      pscale
      psmisc
      pulsemixer
      puppeteer-cli
      redshift
      remote-touchpad
      ripgrep
      rust-analyzer
      rustc
      rustfmt
      rustup
      # rustup-toolchain-install-master
      sassc
      shellcheck
      shellharden
      shfmt
      soulseekqt
      spaceship-prompt
      sqlite
      sqlite-analyzer
      sqlite-interactive
      sqlite-jdbc
      sqlite-utils
      sqlite-web
      sqlint
      sqls
      ssh-chat
      stripe-cli
      stylua
      lua-language-server
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
      # FIX: build fails
      # libreoffice
      # unoconv
      unrar
      unzip
      usbmuxd
      valgrind # debugtooling
      vim
      vim-vint
      w3m
      watchman
      wget
      whois
      # wkhtmltopdf # requires qtwebkit
      xclip
      xh
      yaml-language-server
      yaml-merge
      yaml2json
      # yamlfix nixos-rebuild fails
      yamllint
      yapf
      youtube-dl
      ytfzf
      zathura
      zsh
    ];
}
