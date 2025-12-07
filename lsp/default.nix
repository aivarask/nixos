{ lib, pkgs, ... }:
lib.mkMerge [
  {
    environment.systemPackages = with pkgs; [
      glibc
      # glibcInfo
      clang
      clang-tools
      cunit
      bear
      cmake
      # ccls
      # check
      # meson
      # libcpr
      # nlohmann_json

      # html
      stylelint
      htmx-lsp
      emmet-ls
      emmet-language-server
      ludtwig
      html-tidy
      # json
      vscode-langservers-extracted
      # make
      gnumake
      checkmake
      # markdown
      marksman
      mdformat
      markdownlint-cli
      markdownlint-cli2
      # toml
      taplo
      # yaml
      yaml-language-server
      yq-go
    ];
    environment.pathsToLink = [ "/include" ];
    environment.extraOutputsToInstall = [
      "dev"
      # "info"
    ];
  }
]
