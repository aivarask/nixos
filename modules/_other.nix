{ pkgs, lib, ... }:
lib.mkMerge [
  rec {
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
    environment.systemPackages = with pkgs; [
      ghc
      ghcid
      ghciwatch
    ];
  }
  {
    environment.systemPackages = with pkgs; [
      zig
      zls
      zig-shell-completions
      zap
    ];
  }
  {
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
    environment.systemPackages = with pkgs; [
      vscode-langservers-extracted
      nodePackages.fixjson
    ];
  }
  {
    environment.systemPackages = with pkgs; [
      gnumake
      checkmake
    ];
  }
  {
    environment.systemPackages = with pkgs; [
      marksman
      mdformat
      markdownlint-cli
      markdownlint-cli2
    ];
  }
  {
    environment.systemPackages = with pkgs; [
      taplo
      taplo-cli
      taplo-lsp
    ];
  }
  {
    environment.systemPackages = with pkgs; [
      vim-vint
      nodePackages.vim-language-server
    ];
  }
  {
    environment.systemPackages = with pkgs; [
      yaml-language-server
      yq-go
    ];
  }
  {
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
          playwright
        ]
      ))
    ];
  }
  {
    # environment.systemPackages = with pkgs; [ playwright ];
    environment.sessionVariables = {
      # PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "1";
      PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = "1";
      # PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
      # PLAYWRIGHT_BROWSERS_VERSION = "${pkgs.playwright-driver.version}";
    };
  }
  {
    environment.variables.LD_LIBRARY_PATH = "${pkgs.lldb.lib}/lib/liblldb.so";
    environment.systemPackages = with pkgs; [
      cargo
      cargo-nextest
      rustc
      rust-analyzer
      rustfmt
    ];
  }
  {
    environment.systemPackages = with pkgs; [
      dotenv-linter
      shellharden
      shfmt
      nodePackages.bash-language-server
    ];
  }
]
