{pkgs, ...}: {
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
        plenary-nvim # https://github.com/nvim-lua/plenary.nvim
        std-_debug # https://lua-stdlib.github.io/_debug/
        vicious # https://vicious.readthedocs.io/en/latest/index.html
        luarepl # https://github.com/hoelzro/lua-repl
        linenoise # https://github.com/hoelzro/lua-linenoise
        # REL:
        # modules/services/x11/window-managers/awesome.nix
        # lgi # https://github.com/lgi-devs/lgi
      ]
    );
  environment.variables = {
    LUA_PATH = builtins.concatStringsSep ";" [
      "lua/?.lua"
      "lua/?/init.lua"
      "/etc/nixos/vim/lua/?.lua"
      "/etc/nixos/vim/lua/?/init.lua"
      "${pkgs.luajitPackages.busted.outPath}/share/lua/5.1/?.lua"
      "${pkgs.luajitPackages.busted.outPath}/share/lua/5.1/?/init.lua"
      "${pkgs.luajitPackages.inspect.outPath}/share/lua/5.1/?.lua"
      "${pkgs.luajitPackages.penlight.outPath}/share/lua/5.1/?.lua"
      "${pkgs.luajitPackages.penlight.outPath}/share/lua/5.1/?/init.lua"
      "${pkgs.luajitPackages.plenary-nvim.outPath}/share/lua/5.1/?.lua"
      "${pkgs.luajitPackages.plenary-nvim.outPath}/share/lua/5.1/?/init.lua"
      "${pkgs.luajitPackages.std-_debug.outPath}/share/lua/5.1/?.lua"
      "${pkgs.luajitPackages.std-_debug.outPath}/share/lua/5.1/?/init.lua"
      "${pkgs.luajitPackages.vicious.outPath}/lib/lua/5.1/?.lua"
      "${pkgs.luajitPackages.vicious.outPath}/lib/lua/5.1/?/init.lua"
      # awesome
      "${pkgs.awesome.outPath}/share/awesome/lib/?.lua"
      "${pkgs.awesome.outPath}/share/awesome/lib/?/init.lua"
      # "${pkgs.luajitPackages.lgi.outPath}/share/lua/5.1/?.lua"
      # "${pkgs.luajitPackages.lgi.outPath}/share/lua/5.1/?/init.lua"
      #
    ];
    LUA_LIB = builtins.concatStringsSep ";" [
      "${pkgs.luajitPackages.busted.outPath}/share/lua/5.1"
      "${pkgs.luajitPackages.inspect.outPath}/share/lua/5.1"
      "${pkgs.luajitPackages.penlight.outPath}/share/lua/5.1"
      "${pkgs.luajitPackages.plenary-nvim.outPath}/share/lua/5.1"
      "${pkgs.luajitPackages.std-_debug.outPath}/share/lua/5.1"
      "${pkgs.luajitPackages.vicious.outPath}/lib/lua/5.1"
      # awesome
      "${pkgs.awesome.outPath}/share/awesome/lib"
      # "${pkgs.luajitPackages.lgi.outPath}/share/lua/5.1"
      #
    ];
  };
}
