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
    # ldoc

  ]));
in
{
  environment.systemPackages = with pkgs;
    [
      stylua
      selene
      lua-language-server
      myLuaPackages
    ];

  environment.variables = {
    LUA_PATH = (pkgs.luajitPackages.luaLib.genLuaPathAbsStr myLuaPackages);
    LUA_LIB = "${myLuaPackages}/share/lua/5.1";
  };

  environment.shellAliases = {
    elp = "echo $LUA_PATH | tr ';' '\n'";
    elc = "echo $LUA_CPATH | tr ';' '\n'";
    ell = "echo $LUA_LIB | tr ';' '\n'";
  };

}
