{ pkgs, ... }:
let
  completion = with pkgs.vimPlugins; [
    nvim-autopairs
    cmp_luasnip
    luasnip
    friendly-snippets
    nvim-cmp
    cmp-nvim-lsp
    cmp-nvim-lsp-signature-help
    cmp-nvim-lsp-document-symbol
    cmp-path
    cmp-emoji
    cmp-buffer
    cmp-cmdline
    cmp-zsh
  ];
  dap = with pkgs.vimPlugins; [
    nvim-dap
    nvim-dap-virtual-text
    telescope-dap-nvim
    nvim-dap-ui
    # nvim-dap-go
    # nvim-dap-python
  ];
  lsp = with pkgs.vimPlugins; [
    conform-nvim
    nvim-lspconfig
    SchemaStore-nvim
    none-ls-nvim
    goto-preview
    lsp-overloads-nvim
    lspkind-nvim
    nvim-genghis
  ];
  misc = with pkgs.vimPlugins; [
    outline-nvim
    flatten-nvim
    glow-nvim
    nvim-colorizer-lua
    nvim-web-devicons
    image-nvim
  ];
  telescope = with pkgs.vimPlugins; [
    telescope-nvim
    telescope-fzf-native-nvim
    telescope-symbols-nvim
    trouble-nvim
    todo-comments-nvim
  ];
  testing = with pkgs.vimPlugins; [
    # vim-test
    neotest
    neotest-bash
    neotest-go
    neotest-jest
    neotest-phpunit
    neotest-pest
    # neotest-plenary
    neotest-python
    neotest-rust
    neotest-zig
    neotest-vitest
  ];
  treesitter = with pkgs.vimPlugins; [
    nvim-treesitter.withAllGrammars
    nvim-treesitter-endwise
    nvim-treesitter-context
    nvim-ts-autotag
    nvim-ts-context-commentstring
    nvim-treesitter-textobjects
    nvim-treesitter-textsubjects
  ];
  next = with pkgs.vimPlugins; [
    nui-nvim
    nvim-notify
    plenary-nvim
    fidget-nvim
  ];
  disabled = with pkgs.vimPlugins; [
    vim-indentwise
    # vim-floaterm
    # copilot-cmp
    # copilot-lua
    lf-vim
  ];

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

  home.sessionVariables.NVIM_LISTEN_ADDRESS = "/tmp/nvimsocket";
  programs.neovim = {
    enable = true;
    extraConfig = ''
            let &packpath.=',/etc/nixos'

            let &runtimepath.=',/etc/nixos'

      			runtime! lua/cfg/**/*{.lua,.vim}
            runtime! lua/_*{.lua,.vim}

            set scrolloff=18
            set cmdheight=1
    '';
    extraLuaConfig = ''
      	vim.loader.enable()
    '';
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = false;
  };
  # xdg.dataFile."nvim/plugins".source = programs.neovim.plugins;
  programs.neovim.plugins =
    common
    ++ (with pkgs.vimPlugins; [
      vim-sensible
      nvim-nio
    ])
    ++ completion
    ++ dap
    ++ lsp
    ++ misc
    # ++ testing
    ++ telescope
    ++ treesitter
    ++ next
    ++ (with pkgs.vimPlugins; [
      auto-session
      which-key-nvim
      nvim-surround
      indent-blankline-nvim
      lazygit-nvim
      # neogit
      gitsigns-nvim
      lualine-nvim
      nvim-tree-lua
      neorepl-nvim
      iron-nvim
      toggleterm-nvim
      {
        plugin = sqlite-lua;
        config = "let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.so'";
      }
    ]);
}
