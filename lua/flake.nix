{
  inputs = {
    # nixpkgs.url = "nixpkgs";
  };
  outputs = _: {
    nixosModules = {
      default =
        { pkgs, ... }:
        let
          myLua = pkgs.luajit.withPackages (
            ps: with ps; [
              luv
              cjson
              luasocket # https://github.com/lunarmodules/luasocket
              # https://github.com/rest-nvim/rest.nvim
              magick
              cqueues
              http # https://github.com/daurnimator/lua-http
              inspect
              lpeglabel
              cjson
              luasec
            ]
          );
        in
        {
          environment.etc."lua/lsp".source = pkgs.lua-language-server;
          environment.etc."luajit".source = myLua;
          environment.systemPackages =
            with pkgs;
            [
              neovim-remote
              awesome
              stylua
              lua-language-server
              myLua
            ]
            ++ [
              # pkgs.luajitPackages.inspect
            ];

        };
      neovim.home =
        { ... }:
        {
          imports = [ ./neovim.nix ];
        };
      common.home =
        { pkgs, ... }:
        let
          common = with pkgs.vimPlugins; [
            # pkgs.vimPlugins.vim-indentwise
            vim-auto-save
            vim-indentwise
            bclose-vim
            fzf-vim
            gruvbox-material
            switch-vim
            vim-abolish
            vim-commentary
            vim-cool
            vim-cursorword
            vim-devicons
            vim-highlightedyank
            vim-lastplace
            vim-matchup
            direnv-vim
            vim-markdown
            vim-fugitive
            tabular
          ];
        in
        {
          programs.vim.plugins = common;
        };
      vim.home =
        { pkgs, ... }:
        {
          programs.vim = {
            enable = true;
            plugins = with pkgs.vimPlugins; [
              # vim-repeat vim-sensible vim-matchit
              vim-airline
              vim-which-key
              vim-surround
              auto-pairs
              nerdtree
            ];
            settings = { };
            extraConfig = ''
              let &packpath.=',/etc/nixos'
              let &runtimepath.=',/etc/nixos'
              runtime! lua/cfg/**/*.vim
              runtime! lua/_*.vim
            '';
          };

        };

    };
  };
}
