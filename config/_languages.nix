# vim:foldlevel=3
{ pkgs, lib, ... }:
lib.mkMerge [
  {
    # c
    environment.systemPackages = with pkgs; [
      glibc
      # glibcInfo
      clang
      clang-tools
      cmake
      # ccls
      # check
      # meson
      # libcpr
      # nlohmann_json
    ];
    environment.sessionVariables = {
      # C_INCLUDE_PATH = builtins.concatStringsSep ":" [
      #   "${pkgs.zlib.dev}/include"
      #   "${pkgs.libuv.dev}/include"
      #   "${pkgs.check}/include"
      # ];
      # CPLUS_INCLUDE_PATH = builtins.concatStringsSep ":" [
      #   "${pkgs.curl.dev}/include"
      #   "${pkgs.libcpr.dev}/include"
      #   "${pkgs.nlohmann_json}/include"
      # ];
    };
  }
  rec {
    # go
    environment.sessionVariables.GOPATH = "$HOME/.go";
    environment.sessionVariables.PATH = [ "${environment.sessionVariables.GOPATH}" ];
    environment.systemPackages = with pkgs; [
      go
      gotools
      gopls
      templ
      gow
      delve
    ];
  }
  {
    # sql
    environment.systemPackages = with pkgs; [
      sqlite-interactive
      sqlite-analyzer
      sqlite-web

      sqlint
      sqlfluff # 7k

      sqls # 0.8k
      postgres-lsp # 3.1k
    ];
    networking.firewall.allowedTCPPorts = [
      3306 # mysql
      5434 # postgresql
    ];
    services.mysql = {
      enable = false;
      package = pkgs.mariadb;
      settings = {
        # /etc/my.cnf
        mysql = {
          auto-rehash = true;
        };
      };
    };
    services.postgresql = {
      enable = false;
      package = pkgs.postgresql;
      ensureDatabases = [ "test" ];
      authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser  auth-method
        local all       all     trust
      '';
    };
  }
  {
    # haskell
    environment.systemPackages = with pkgs; [
      ghc
      ghcid
      ghciwatch
    ];
  }
  {
    # zig
    environment.systemPackages = with pkgs; [
      zig
      zls
      zig-shell-completions
      zap
    ];
  }
  {
    # html
    environment.systemPackages = with pkgs; [
      stylelint
      htmx-lsp
      emmet-ls
      emmet-language-server
      ludtwig
      html-tidy
    ];
  }
  {
    # json
    environment.systemPackages = with pkgs; [
      vscode-langservers-extracted
      nodePackages.fixjson
    ];
  }
  {
    # make
    environment.systemPackages = with pkgs; [
      gnumake
      checkmake
    ];
  }
  {
    # markdown
    environment.systemPackages = with pkgs; [
      marksman
      mdformat
      markdownlint-cli
      markdownlint-cli2
    ];
  }
  {
    # node
    environment.sessionVariables = rec {
      NODE_OPTIONS = "--no-warnings";
      PNPM_HOME = "$HOME/.pnpm";
      VSCODE_JS_DEBUG = "${pkgs.vscode-js-debug.outPath}";
      PATH = [
        "${PNPM_HOME}"
        "$HOME/.npm/bin"
      ];
    };
    environment.systemPackages =
      with pkgs;
      [
        nodejs_22
        corepack_22
        eslint_d
        # typescript
        vscode-js-debug
        stylelint-lsp
      ]
      ++ (with pkgs.nodePackages; [
        pnpm # ~/.pnpm-global
        serve
        pm2
        dotenv-cli
        prettierd
        typescript-language-server
        jsdoc
      ]);
  }
  {
    # toml
    environment.systemPackages = with pkgs; [
      taplo
      taplo-cli
      taplo-lsp
    ];
  }
  {
    # vim
    environment.systemPackages = with pkgs; [
      vim-vint
      nodePackages.vim-language-server
    ];
  }
  {
    # yaml
    environment.systemPackages = with pkgs; [
      yaml-language-server
      yq-go
    ];
  }
  {
    # python
    environment.systemPackages = with pkgs; [
      pyright
      black
      (python3.withPackages (
        ps: with ps; [
          pip
          requests
          pytest
          pytest-watch
          pytest-timeout
          pytest-playwright
          pynvim
          livereload
          debugpy
          python-dotenv
          httpie
          # playwright
          yt-dlp
        ]
      ))
    ];
  }

]
