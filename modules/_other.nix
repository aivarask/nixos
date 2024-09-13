{ pkgs, lib, ... }:
lib.mkMerge [
  {
    environment.systemPackages = with pkgs; [ stylelint ];
    environment.shellAliases = {
      stylelint = "stylelint -c /etc/nixos/.stylelintrc.json --config-basedir /etc/nixos";
    };
  }
  {
    environment.systemPackages = with pkgs; [
      htmx-lsp
      emmet-ls
      emmet-language-server
      ludtwig
      html-tidy
    ];
  } # html
  {
    environment.systemPackages = with pkgs; [
      vscode-langservers-extracted
      nodePackages.fixjson
    ];
  } # json
  {
    environment.systemPackages = with pkgs; [
      gnumake
      checkmake
    ];
  } # make
  {
    environment.systemPackages = with pkgs; [
      marksman
      mdformat
      markdownlint-cli
      markdownlint-cli2
    ];
  } # markdown
  {
    environment.systemPackages = with pkgs; [
      taplo
      taplo-cli
      taplo-lsp
    ];
  } # toml
  {
    environment.systemPackages = with pkgs; [
      vim-vint
      nodePackages.vim-language-server
    ];
  } # vim
  {
    environment.systemPackages = with pkgs; [
      yaml-language-server
      yq-go
    ];
  } # yaml
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
        ]
      ))
    ];
  }
  {
    environment.systemPackages = with pkgs; [ playwright ];
    environment.sessionVariables = {
      # PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "1";
      PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = "1";
      PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
      PLAYWRIGHT_BROWSERS_VERSION = "${pkgs.playwright-driver.version}";
    };
  }

  {
    # rust rust-bin.stable.latest.default
    environment.variables = {
      LD_LIBRARY_PATH = "${pkgs.lldb.lib}/lib/liblldb.so";
    };
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
