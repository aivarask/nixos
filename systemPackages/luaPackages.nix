{ pkgs, ... }: {
  environment.systemPackages =
    (with pkgs; [
      stylua
      lua-language-server
      luaformatter
      luajit
      luakit
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
