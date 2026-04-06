{ pkgs, inputs, ... }:
let
  myLua = pkgs.luajit.withPackages (
    ps: with ps; [
      # https://github.com/rest-nvim/rest.nvim
      lgi
      pkgs.luajitPackages.mp
      mp
      luv
      cjson
      luasocket # https://github.com/lunarmodules/luasocket
      magick
      cqueues
      http # https://github.com/daurnimator/lua-http
      inspect
      lpeglabel
      cjson
      luasec
      luasql-sqlite3
      penlight
      plenary-nvim
      luafilesystem
      # nlua # nvim as lua interpreter
      busted
    ]
  );
in
{
  environment.etc."luajit".source = myLua;
  environment.etc."lua-language-server".source = pkgs.lua-language-server;
  environment.pathsToLink = [ "/include" ];
  # environment.extraOutputsToInstall = [ "dev" ];
  environment.systemPackages = with pkgs; [
    tree-sitter
    vscode-json-languageserver
    vscode-css-languageserver
    # vscode-langservers-extracted
    glibc
    # glibcInfo
    clang
    clang-tools
    bear
    cmake
    ludtwig
    intelephense
    gnumake
    checkmake
    taplo
    yaml-language-server
    nixfmt
    nixd
    nurl
    deadnix
    stylelint
    stylelint-lsp
    stylua
    lua-language-server
    myLua
    editorconfig-checker
    editorconfig-core-c
  ];
  nixpkgs.overlays = [
    (
      _: prev:
      let
        inherit (prev.vimUtils) buildVimPlugin;
      in
      {
        vimPlugins = with inputs; prev.vimPlugins // { };
      }
    )
  ];
}
