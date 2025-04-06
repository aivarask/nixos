{
  inputs = {
    vim-log-highlighting = {
      url = "github:MTDL9/vim-log-highlighting";
      flake = false;
    };
    vim-interestingwords = {
      url = "github:lfv89/vim-interestingwords";
      flake = false;
    };
    nvim-lsp-file-operations = {
      url = "github:antosha417/nvim-lsp-file-operations";
      flake = false;
    };
    neotest-playwright = {
      url = "github:thenbe/neotest-playwright";
      flake = false;
    };
    persistent-breakpoints = {
      url = "github:Weissle/persistent-breakpoints.nvim";
      flake = false;
    };
    smart-semicolon = {
      url = "github:iagotito/smart-semicolon.nvim";
      flake = false;
    };
    one-small-step-for-vimkind = {
      url = "github:jbyuki/one-small-step-for-vimkind";
      flake = false;
    };
    tree-sitter-language-injection = {
      url = "github:DariusCorvus/tree-sitter-language-injection.nvim";
      flake = false;
    };
    # https://github.com/samsze0/websocket.nvim
    websocket-nvim = {
      url = "github:samsze0/websocket.nvim";
      flake = false;
    };
    nvim-oxi = {
      # https://github.com/noib3/nvim-oxi
      url = "github:noib3/nvim-oxi";
      flake = false;
    };
    # https://github.com/mlua-rs/mlua
  };
  outputs =
    { self, ... }@inputs:
    {
      overlays.default = (
        _: prev:
        let
          inherit (prev.vimUtils) buildVimPlugin;
        in
        {
          vimPlugins =
            with inputs;
            prev.vimPlugins
            // {
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
                meta = {
                  homepage = "https://github.com/jbyuki/one-small-step-for-vimkind";
                };
              };
              vim-log-highlighting = buildVimPlugin {
                name = "vim-log-highlighting";
                src = vim-log-highlighting;
                meta = {
                  homepage = "https://github.com/MTDL9/vim-log-highlighting";
                };
              };
              vim-interestingwords = buildVimPlugin {
                name = "vim-interestingwords";
                src = vim-interestingwords;
                meta = {
                  homepage = "https://github.com/lfv89/vim-interestingwords";
                };
              };
              nvim-lsp-file-operations = buildVimPlugin {
                name = "nvim-lsp-file-operations";
                src = nvim-lsp-file-operations;
                meta = {
                  homepage = "https://github.com/antosha417/nvim-lsp-file-operations";
                };
                doCheck = false;
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
      );
      nixosModules = {
        default =
          { pkgs, ... }:
          {
            nixpkgs.overlays = [ self.overlays.default ];
          };
        lua =
          { pkgs, ... }:
          let
            myLua = pkgs.luajit.withPackages (
              ps: with ps; [
                # https://github.com/rest-nvim/rest.nvim
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
            environment.etc."luajit".source = myLua;
            environment.etc."lua-language-server".source = pkgs.lua-language-server;
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
        commonPlugins =
          {
            pkgs,
            lib,
            config,
            ...
          }:
          let
            vimOnlyPlugins = with pkgs.vimPlugins; [
              vim-indentwise
              vim-commentary
              vim-matchup
              # vim-markdown
              # vim-floaterm
              # lf-vim
            ];
            neovimOnlyPlugins = with pkgs.vimPlugins; [
              vim-sensible
              nvim-nio
              auto-session
              which-key-nvim
              # nvim-surround
              indent-blankline-nvim
              lazygit-nvim
              # neogit
              gitsigns-nvim
              lualine-nvim
              nvim-tree-lua
              neorepl-nvim
              iron-nvim
              toggleterm-nvim
              # {
              #   plugin = sqlite-lua;
              #   config = "let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.so'";
              # }
            ];
            common = with pkgs.vimPlugins; [
              vim-auto-save
              bclose-vim
              fzf-vim
              gruvbox-material
              switch-vim
              vim-abolish
              vim-cool
              vim-cursorword
              vim-devicons
              vim-highlightedyank
              vim-lastplace
              direnv-vim
              vim-fugitive
              tabular
              vim-log-highlighting
              vim-interestingwords
            ];
          in
          {
            programs.vim.plugins = lib.mkIf (config.programs.vim.enable == true) (common ++ vimOnlyPlugins);
            programs.neovim.plugins = lib.mkIf (config.programs.neovim.enable == true) (
              common ++ neovimOnlyPlugins
            );
          };
        vim =
          { pkgs, config, ... }:
          {
            xdg.configFile."vim".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/vim";
            programs.vim = {
              enable = true;
              extraConfig = ''source $XDG_CONFIG_HOME/vim/vimrc'';
              plugins = with pkgs.vimPlugins; [
                vim-airline
                vim-which-key
                vim-surround
                auto-pairs
                nerdtree
                # vim-repeat
                # vim-sensible
                # vim-matchit
              ];
            };
          };
        neovim =
          { config, ... }:
          {
            imports = [ ./neovim.nix ];
            home.sessionVariables.NVIM_LISTEN_ADDRESS = "/tmp/nvimsocket";
            xdg.configFile."nvim/init.vim".source =
              config.lib.file.mkOutOfStoreSymlink "/etc/nixos/vim/init.vim";
            programs.neovim = {
              enable = true;
              # extraConfig = ''source $XDG_CONFIG_HOME/nvim/init.vim'';
              # extraLuaConfig = ''
              #   vim.loader.enable()
              #
              # '';
              vimdiffAlias = true;
              withPython3 = true;
              withNodeJs = true;
              withRuby = false;
            };
            programs.neovim.extraLuaPackages =
              ps: with ps; [
                penlight
                cjson
                http
                cqueues
                luaossl
                basexx
                lpeg
                lpeg_patterns
                binaryheap
                fifo # dep in neovim only
                lua-zlib
                compat53
                # lua-psl
              ];
          };
        neovimOverlays =
          { pkgs, ... }:
          {
            programs.neovim.plugins = (
              with pkgs.vimPlugins;
              [
                one-small-step-for-vimkind
                nvim-lsp-file-operations
                neotest-playwright
                persistent-breakpoints
                smart-semicolon
                tree-sitter-language-injection
                websocket-nvim
                nvim-oxi
              ]
            );
          };
      };
    };
}
