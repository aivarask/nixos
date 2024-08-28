{ pkgs, ... }:
let
  codelens = with pkgs.vimPlugins;[
    # fold-preview-nvim
    goto-preview
    hover-nvim
    # pretty-fold-nvim
  ];
  completion = with pkgs.vimPlugins; [
    nvim-autopairs
    cmp_luasnip
    luasnip
    friendly-snippets
    nvim-cmp
    cmp-nvim-lsp
    cmp-emoji
    cmp-path
    cmp-buffer
    cmp-cmdline
    cmp-zsh
    cmp-git
    cmp-dap
  ];
  dap = with pkgs.vimPlugins; [
    nvim-dap
    nvim-dap-ui
    nvim-dap-virtual-text
    nvim-dap-go
    nvim-dap-python
    nvim-dap-vscode-js
    # rustaceanvim
  ];
  lsp = with pkgs.vimPlugins; [
    conform-nvim
    SchemaStore-nvim
    nvim-lspconfig
    none-ls-nvim
    nvim-lsp-file-operations
    refactoring-nvim
    lsp_signature-nvim
    lsp-overloads-nvim
  ];
  misc = with pkgs.vimPlugins; [
    aerial-nvim
    outline-nvim
    flatten-nvim
    glow-nvim
    neoscroll-nvim
    dressing-nvim
    nvim-colorizer-lua
    nvim-web-devicons
    image-nvim
  ];
  telescope = with pkgs.vimPlugins; [
    telescope-nvim
    telescope-fzf-native-nvim
    telescope-dap-nvim
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
    neotest-playwright
    neotest-plenary
    neotest-python
    neotest-rust
    neotest-zig
    neotest-vitest
  ];
  treesitter =
    with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      nvim-treesitter-endwise
      nvim-treesitter-context
      nvim-ts-autotag
      nvim-ts-context-commentstring
      nvim-treesitter-textobjects
      nvim-treesitter-textsubjects
    ];
  next =
    with pkgs.vimPlugins; [
      nui-nvim
    ];
in
{
  programs.neovim.extraLuaPackages = ps: [
    ps.magick #NOTE: @dep image-nvim
  ];
  programs.neovim.plugins =
    codelens
    ++ completion
    ++ dap
    ++ lsp
    ++ misc
    ++ testing
    ++ telescope
    ++ treesitter
    ++ next
    ++ (with pkgs.vimPlugins; [
      sxhkd-vim
      persistent-breakpoints
      auto-session
      which-key-nvim
      nvim-surround
      indent-blankline-nvim
      lazygit-nvim
      neogit
      gitsigns-nvim
      lualine-nvim
      lualine-lsp-progress
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
