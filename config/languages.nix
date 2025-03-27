{ pkgs, lib, ... }:
lib.mkMerge [

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
        # stylelint-lsp
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
      # nodePackages.vim-language-server
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
          # pytest-playwright
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
