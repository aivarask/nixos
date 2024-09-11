# https://nixos.wiki/wiki/Lua
{ pkgs, ... }:
let
  myLuaPackages = with pkgs; (luajit.withPackages (ps: with ps; [
    # lgi 
    # luarepl
    # vicious
    # vusted
    penlight
    busted
    luassert
    plenary-nvim
    inspect
    magick
    jsregexp
    ldoc
    luacheck
    luadbi-sqlite3
    luafilesystem
    luasql-sqlite3
    luv
    nvim-nio
    sqlite
    std-_debug
    toml-edit
  ]));

  myLuaLib = with pkgs; (luajit.withPackages (ps: with ps; [
    penlight
    busted
    luassert
    plenary-nvim

  ]));
in
{
  environment.systemPackages = with pkgs;
    [
      lua-language-server
      myLuaPackages
    ];

  environment.variables = {
    LUA_PATH = (pkgs.luajitPackages.luaLib.genLuaPathAbsStr myLuaPackages);
    LUA_LIB = "${myLuaLib}/share/lua/5.1";
    # LUA_CPATH = "${pkgs.sqlite.out}/lib/libsqlite3.so.0.8.6";
    # LUA_CPATH = "${pkgs.sqlite.out}/lib/libsqlite3.so";
    LUA_CPATH = "${(pkgs.luajitPackages.luaLib.genLuaCPathAbsStr myLuaPackages)};${pkgs.sqlite.out}/lib/libsqlite3.so";
  };

  environment.shellAliases = {
    elp = "echo $LUA_PATH | tr ';' '\n'";
    elc = "echo $LUA_CPATH | tr ';' '\n'";
    ell = "echo $LUA_LIB | tr ';' '\n'";
  };

}
