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
      # nlua # nvim as lua interpreter
    ]
  );
in
{
  environment.etc."awesome".source = pkgs.awesome;
  environment.etc."luajit".source = myLua;
  environment.etc."lua-language-server".source = pkgs.lua-language-server;
  environment.systemPackages = with pkgs; [
    neovim-remote
    awesome
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
            sxhkd-vim = buildVimPlugin {
              name = "sxhkd-vim";
              src = inputs.sxhkd-vim;
              doCheck = false;
              meta.home = inputs.sxhkd-vim.url;
            };
            websocket-nvim = buildVimPlugin {
              name = "websocket-nvim";
              src = websocket-nvim;
              meta.homepage = "github.com/samsze0/websocket.nvim";
              doCheck = false;
            };
            nvim-oxi = buildVimPlugin {
              name = "nvim-oxi";
              src = nvim-oxi;
              meta.home = "https://github.com/noib3/nvim-oxi";
            };
            one-small-step-for-vimkind = buildVimPlugin {
              name = "one-small-step-for-vimkind";
              src = one-small-step-for-vimkind;
              meta.homepage = "https://github.com/jbyuki/one-small-step-for-vimkind";
            };
            vim-log-highlighting = buildVimPlugin {
              name = "vim-log-highlighting";
              src = vim-log-highlighting;
              meta.homepage = "https://github.com/MTDL9/vim-log-highlighting";
            };
            vim-interestingwords = buildVimPlugin {
              name = "vim-interestingwords";
              src = vim-interestingwords;
              meta.homepage = "https://github.com/lfv89/vim-interestingwords";
            };
            neotest-playwright = buildVimPlugin {
              name = "neotest-playwright";
              src = neotest-playwright;
              meta = {
                homepage = "https://github.com/thenbe/neotest-playwright";
              };
              doCheck = false;
            };
            persistent-breakpoints = buildVimPlugin {
              name = "persistent-breakpoints";
              src = persistent-breakpoints;
              meta = {
                homepage = "https://github.com/Weissle/persistent-breakpoints.nvim";
              };
              doCheck = false;
            };
            smart-semicolon = buildVimPlugin {
              name = "smart-semicolon";
              src = smart-semicolon;
              meta = {
                homepage = "https://github.com/iagotito/smart-semicolon.nvim";
              };
            };
            tree-sitter-language-injection = buildVimPlugin {
              name = "tree-sitter-language-injection";
              src = tree-sitter-language-injection;
              meta = {
                homepage = "https://github.com/DariusCorvus/tree-sitter-language-injection.nvim";
              };
            };
          };
      }
    )
  ];
}
