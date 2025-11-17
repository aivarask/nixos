{
  pkgs,
  lib,
  config,
  osConfig,
  inputs,
  ...
}:
let
  common = with pkgs.vimPlugins; [
    ack-vim
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
    tabular
    vim-log-highlighting
    vim-interestingwords
    # alternatives exist
    vim-surround
  ];
in
{
  xdg.configFile."vim".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/lua";
  programs.vim.enable = true;
  programs.vim.extraConfig = ''source $XDG_CONFIG_HOME/vim/vimrc'';
  programs.vim.plugins = lib.mkIf (config.programs.vim.enable == true) (
    lib.mkMerge [
      common
      (with pkgs.vimPlugins; [
        vim-airline
        vim-which-key
        auto-pairs
        nerdtree
        #
        vim-indentwise
        vim-commentary
        vim-matchup
      ])
    ]
  );
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/lua";
  programs.neovim.enable = true;
  programs.neovim.package =
    inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
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
      fifo # dep in neovim only
      lua-zlib
      compat53
      # lua-psl
    ];
  home.sessionVariables.SQLITE_CLIB_PATH = "${pkgs.sqlite.out}/lib/libsqlite3${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}";
  programs.neovim.plugins = lib.mkIf (config.programs.neovim.enable == true) (
    lib.mkMerge [
      common
      (with pkgs.vimPlugins; [
        # nvimOnly
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
        iron-nvim
        toggleterm-nvim
        sqlite-lua
      ])
      (with pkgs.vimPlugins; [
        # new
        nui-nvim
        nvim-notify
        fidget-nvim
        luvit-meta
        # overlays
        one-small-step-for-vimkind
        nvim-lsp-file-operations
        neotest-playwright
        persistent-breakpoints
        smart-semicolon
        tree-sitter-language-injection
        websocket-nvim
        nvim-oxi
      ])
      # misc
      (lib.mkIf true (
        with pkgs.vimPlugins;
        [
          SchemaStore-nvim
          outline-nvim
          flatten-nvim
          nvim-colorizer-lua
          nvim-web-devicons
          image-nvim
          telescope-nvim
          telescope-fzf-native-nvim
          telescope-symbols-nvim
          telescope-manix
          telescope-smart-history-nvim
          telescope-frecency-nvim
        ]
      ))
      # debug
      (lib.mkIf false (
        with pkgs.vimPlugins;
        [
          nvim-dap
          nvim-dap-virtual-text
          telescope-dap-nvim
          nvim-dap-ui
          # nvim-dap-go
          # nvim-dap-python
        ]
      ))
      # test
      (lib.mkIf true (
        with pkgs.vimPlugins;
        [
          # vim-test
          pkgs.vimPlugins.neotest
          # neotest-bash
          # neotest-go
          # neotest-jest
          # neotest-phpunit
          # neotest-pest
          # neotest-plenary
          neotest-python
          # neotest-rust
          # neotest-vitest
        ]
      ))
      # treesitter
      (lib.mkIf true (
        with pkgs.vimPlugins;
        [
          nvim-treesitter.withAllGrammars
          nvim-treesitter-endwise
          nvim-treesitter-context
          nvim-ts-autotag
          nvim-ts-context-commentstring
          nvim-treesitter-textobjects
          nvim-treesitter-textsubjects
        ]
      ))

    ]
  );
}
