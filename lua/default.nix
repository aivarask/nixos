{ pkgs, inputs, ... }:
let
  myLua = pkgs.luajit.withPackages (
    ps: with ps; [
      # https://github.com/rest-nvim/rest.nvim
      lgi
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
  environment.systemPackages = with pkgs; [
    vscode-json-languageserver
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
        vimPlugins =
          with inputs;
          prev.vimPlugins
          // {
            smart-semicolon = buildVimPlugin {
              name = "smart-semicolon";
              src = smart-semicolon;
              meta = {
                homepage = "https://github.com/iagotito/smart-semicolon.nvim";
              };
            };
          };
      }
    )
  ];
}
