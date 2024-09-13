{ pkgs, ... }:
let
  myLuaPackages =
    with pkgs;
    (luajit.withPackages (
      ps: with ps; [
        # lgi 
        # luarepl
        # vicious
        # vusted
        inspect
        magick
        jsregexp
        ldoc
        luacheck
        luadbi-sqlite3
        luafilesystem
        luasql-sqlite3
        luv
        sqlite
        std-_debug
        toml-edit
      ]
    ));
  myLuaLib =
    with pkgs;
    (luajit.withPackages (
      ps: with ps; [
        penlight
        busted
        luassert
        plenary-nvim
        nvim-nio
      ]
    ));
in
{
  environment.systemPackages = with pkgs; [
    lua-language-server
    myLuaPackages
  ];
  environment.variables = {
    LUA_PATH = builtins.concatStringsSep ";" [
      (pkgs.luajitPackages.luaLib.genLuaPathAbsStr myLuaPackages)
    ];
    LUA_CPATH = builtins.concatStringsSep ";" [
      (pkgs.luajitPackages.luaLib.genLuaCPathAbsStr myLuaPackages)
      (pkgs.luajitPackages.luaLib.genLuaCPathAbsStr myLuaLib)
      "${pkgs.sqlite.out}/lib/libsqlite3.so"
    ];
    LUA_LIB = "${myLuaLib}/share/lua/5.1";
  };
  environment.shellAliases = {
    elp = "echo $LUA_PATH | tr ';' '\n'";
    elc = "echo $LUA_CPATH | tr ';' '\n'";
  };

}
