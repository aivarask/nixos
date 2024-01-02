# https://nixos.wiki/wiki/Lua
{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # stylua
    # lua-language-server
    # (luajit.withPackages (ps: with ps; [ busted luafilesystem ]))
  ];

  environment.shellAliases = {
    elp = "echo $LUA_PATH | tr ';' '\n'";
    elc = "echo $LUA_CPATH | tr ';' '\n'";
    ell = "echo $LUA_LIB | tr ';' '\n'";
  };

}
