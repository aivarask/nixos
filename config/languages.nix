{ pkgs, lib, ... }:
lib.mkMerge [

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
    # vim
    environment.systemPackages = with pkgs; [
      vim-vint
      # nodePackages.vim-language-server
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
