# https://nixos.wiki/wiki/Lua
{ pkgs, ... }:
let
  myLuaPackages = with pkgs; (luajit.withPackages (ps: with ps; [
    luassert
    busted
    penlight
    luafilesystem
    luv
    luacheck
    std-_debug
    inspect
    # vusted
    plenary-nvim
    # vicious
    # luarepl
    # lgi 
    ldoc
    nvim-nio
    sqlite
    luasql-sqlite3
    luadbi-sqlite3
    toml
    jsregexp
  ]));

in
{
  environment.systemPackages = with pkgs;
    [
      selene
      lua-language-server
      myLuaPackages
    ];

  environment.variables = {
    LUA_PATH = (pkgs.luajitPackages.luaLib.genLuaPathAbsStr myLuaPackages);
    LUA_LIB = "${myLuaPackages}/share/lua/5.1";
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
