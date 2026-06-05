# vim: nofoldenable
{ ... }:
{

  home-manager.sharedModules = [
    (
      {
        pkgs,
        lib,
        config,
        inputs,
        ...
      }:
      let
        COMMON = with pkgs.vimPlugins; [
          gruvbox-material
          vim-commentary
          vim-highlightedyank
          vim-scriptease
          vim-obsession
          vim-gutentags
          vim-vinegar
          vim-nix
          vim-lsp
          vim-css-color
          switch-vim
        ];
      in
      {
        # home.packages {{{
        home.packages = with pkgs; [
          clang
          clang-tools
          bear
          cmake
          libsixel
          pkg-config
          universal-ctags
          cscope
          gdb
          (pkgs.netsurf-browser.override { uilib = "gtk3"; }) # framebuffer
          pkgs.xterm
          lsix
          viu
          cadaver
          fetch-scm
          # elinks
          tree-sitter
          pandoc
        ];
        # }}}
        # vim {{{
        programs.vim.enable = true;
        programs.vim.extraConfig = ''
          set runtimepath^=/etc/nixos 
          set runtimepath+=/etc/nixos/after 
          source /etc/nixos/vimrc
        '';
        programs.vim.plugins = lib.mkIf (config.programs.vim.enable == true) (lib.mkMerge [ COMMON ]);
        home.sessionVariables.VIM9 = "${config.programs.vim.package}/share/vim/vim92";

        # }}}

        # nvim {{{
        programs.neovim.enable = true;
        programs.neovim.initLua =
          let
            nvimEarlyInit = lib.mkOrder 500 ''
              vim.opt.runtimepath:prepend('/etc/nixos')
              vim.opt.runtimepath:append('/etc/nixos/after')
              vim.cmd.source('/etc/nixos/vimrc')
              require('vimrc')
            '';
          in
          lib.mkMerge [
            nvimEarlyInit
          ];
        home.sessionVariables.SQLITE_CLIB_PATH = "${pkgs.sqlite.out}/lib/libsqlite3${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}";
        programs.neovim.package =
          inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
        programs.neovim.plugins = lib.mkIf (config.programs.neovim.enable == true) (
          lib.mkMerge [
            COMMON
            (with pkgs.vimPlugins; [
              # nvim-treesitter.withAllGrammars
              # (nvim-treesitter.withPlugins (ps: [ ps.nix ]))
              nvim-nio
              SchemaStore-nvim
              flatten-nvim
              nvim-web-devicons
              mini-icons
              image-nvim
              sqlite-lua
              kitty-scrollback-nvim
              nvim-notify
              fidget-nvim
              luvit-meta
            ])

          ]
        );
        programs.neovim.extraLuaPackages =
          ps: with ps; [
            plenary-nvim
            penlight
            cjson
            http
            cqueues
            luaossl
            basexx
            lpeg
            lpeg_patterns
            binaryheap
            luafilesystem
            fifo
            lua-zlib
            compat53
          ];
        # }}}

      }
    )

  ];

}
