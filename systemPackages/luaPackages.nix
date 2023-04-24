{pkgs, ...}: {
  environment.variables = {
    LUA_PATH = builtins.concatStringsSep ";" [
      "lua/?.lua"
      "lua/?/init.lua"
      "${pkgs.luajitPackages.plenary-nvim.outPath}/share/lua/5.1/?.lua"
      "${pkgs.luajitPackages.plenary-nvim.outPath}/share/lua/5.1/?/init.lua"
      "${pkgs.luajitPackages.inspect.outPath}/share/lua/5.1/?.lua"
      "${pkgs.luajitPackages.penlight.outPath}/share/lua/5.1/?.lua"
      "${pkgs.luajitPackages.penlight.outPath}/share/lua/5.1/?/init.lua"
    ];
    LUA_LIB = builtins.concatStringsSep ";" [
      "${pkgs.luajitPackages.penlight.outPath}/share/lua/5.1"
    ];
  };
  environment.systemPackages =
    (with pkgs; [
      stylua
      lua-language-server
      luaformatter
      luajit
      luakit # web browser
    ])
    ++ (
      with pkgs.luajitPackages; [
        busted # https://lunarmodules.github.io/busted/
        inspect # https://github.com/kikito/inspect.lua
        penlight # https://github.com/lunarmodules/Penlight
        std-_debug # https://lua-stdlib.github.io/_debug/
        plenary-nvim # https://github.com/nvim-lua/plenary.nvim
      ]
    );
}
